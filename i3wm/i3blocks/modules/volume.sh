#!/bin/bash
# install instructions
# git clone https://github.com/vivien/i3blocks-contrib
# cp i3blocks-contrib/volume/volume ~/i3blocks/modules/

# Add this to i3 config:
# change volume or toggle mute
#bindsym XF86AudioRaiseVolume exec amixer -q -D pulse sset Master 5%+ && pkill -RTMIN+10 i3blocks 
#bindsym XF86AudioLowerVolume exec amixer -q -D pulse sset Master 5%- && pkill -RTMIN+10 i3blocks
#bindsym XF86AudioMute exec amixer -q -D pulse sset Master toggle && pkill -RTMIN+10 i3blocks






# The second parameter overrides the mixer selection
# For PulseAudio users, eventually use "pulse"
# For Jack/Jack2 users, use "jackplug"
# For ALSA users, you may use "default" for your primary card
# or you may use hw:# where # is the number of the card desired
if [[ -z "$MIXER" ]] ; then
    MIXER="default"
    if command -v pulseaudio >/dev/null 2>&1 && pulseaudio --check ; then
        # pulseaudio is running, but not all installations use "pulse"
        if amixer -D pulse info >/dev/null 2>&1 ; then
            MIXER="pulse"
        fi
    fi
    [ -n "$(lsmod | grep jack)" ] && MIXER="jackplug"
    MIXER="${2:-$MIXER}"
fi

# The instance option sets the control to report and configure
# This defaults to the first control of your selected mixer
# For a list of the available, use `amixer -D $Your_Mixer scontrols`
if [[ -z "$SCONTROL" ]] ; then
    SCONTROL="${BLOCK_INSTANCE:-$(amixer -D $MIXER scontrols |
                      sed -n "s/Simple mixer control '\([^']*\)',0/\1/p" |
                      head -n1
                    )}"
fi

# The first parameter sets the step to change the volume by (and units to display)
# This may be in in % or dB (eg. 5% or 3dB)
if [[ -z "$STEP" ]] ; then
    STEP="${1:-5%}"
fi

# AMIXER(1):
# "Use the mapped volume for evaluating the percentage representation like alsamixer, to be
# more natural for human ear."
NATURAL_MAPPING=${NATURAL_MAPPING:-0}
if [[ "$NATURAL_MAPPING" != "0" ]] ; then
    AMIXER_PARAMS="-M"
fi

#------------------------------------------------------------------------

capability() { # Return "Capture" if the device is a capture device
  amixer $AMIXER_PARAMS -D $MIXER get $SCONTROL |
    sed -n "s/  Capabilities:.*cvolume.*/Capture/p"
}

volume() {
  amixer $AMIXER_PARAMS -D $MIXER get $SCONTROL $(capability)
}

format() {
  
  perl_filter='if (/.*\[(\d+%)\] (\[(-?\d+.\d+dB)\] )?\[(on|off)\]/)'
  perl_filter+='{CORE::say $4 eq "off" ? "MUTE" : "'
  # If dB was selected, print that instead
  perl_filter+=$([[ $STEP = *dB ]] && echo '$3' || echo '$1')
  perl_filter+='"; exit}'
  output=$(perl -ne "$perl_filter")
  echo "$LABEL$output"
}

#------------------------------------------------------------------------

case $BLOCK_BUTTON in
  3) amixer $AMIXER_PARAMS -q -D $MIXER sset $SCONTROL $(capability) toggle ;;  # right click, mute/unmute
  4) amixer $AMIXER_PARAMS -q -D $MIXER sset $SCONTROL $(capability) ${STEP}+ unmute ;; # scroll up, increase
  5) amixer $AMIXER_PARAMS -q -D $MIXER sset $SCONTROL $(capability) ${STEP}- unmute ;; # scroll down, decrease
esac

volume | format
