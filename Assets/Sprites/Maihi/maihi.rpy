# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# CODE WRITTEN BY AR_0 WITH THE HELP OF REN'PY OFFICIAL DOCUMENTATION #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

transform angry_atl():
    alpha 0.0 xalign 0.5 yalign 0.25 xsize 0 ysize 0 rotate -20 subpixel True
    ease 0.2 alpha 1.0 xsize 155 ysize 153 rotate 0
    ease 1.0 xsize 145 ysize 143
    ease 1.0 xsize 155 ysize 153
    ease 1.0 xsize 145 ysize 143
    ease 1.0 xsize 155 ysize 153
    ease 0.5 alpha 0.0 xsize 0 ysize 0 rotate 20
    repeat # delete this to get rid of the looping effect

transform blush_atl():
    alpha 1.0 xalign 0.4 yalign 0.45

transform disappointed_atl():
    alpha 0.0 xalign 0.52 yalign 0.2 subpixel True
    ease 0.2 alpha 1.0 yalign 0.2
    ease 3.5 alpha 1.0 yalign 0.25
    ease 0.5 alpha 0.0
    repeat # delete this to get rid of the looping effect

transform notice_atl():
    alpha 0.0 xalign 0.52 yalign 0.2 rotate -5 subpixel True
    ease 0.2 alpha 1.0 xalign 0.58
    ease 1.5 xalign 0.58 rotate 10
    ease 1.5 xalign 0.58 rotate -5  
    ease 0.5 alpha 0.0 rotate -5
    repeat # delete this to get rid of the looping effect

transform exclaim_atl():
    alpha 0.0 xalign 0.52 yalign 0.2 xsize 0 ysize 0 rotate -20 subpixel True
    ease 0.2 alpha 1.0 xsize 53 ysize 228 rotate 0
    ease 1.0 xsize 43 ysize 218
    ease 1.0 xsize 53 ysize 228
    ease 1.0 xsize 43 ysize 218
    ease 1.0 xsize 53 ysize 228
    ease 0.5 alpha 0.0 xsize 0 ysize 0 rotate 20
    repeat # delete this to get rid of the looping effect

transform question_atl():
    alpha 0.0 xalign 0.55 yalign 0.2 rotate -20 subpixel True
    ease 0.2 alpha 1.0 xsize 137 ysize 224 rotate 0
    ease 1.0 xsize 127 ysize 214
    ease 1.0 xsize 137 ysize 224
    ease 1.0 xsize 127 ysize 214
    ease 1.0 xsize 137 ysize 224
    ease 0.5 alpha 0.0 xsize 0 ysize 0 rotate 20
    repeat # delete this to get rid of the looping effect

default m_mouth = "neutral"
# SMILING →      $ m_mouth = "smile"
# GRINNING →     $ m_mouth = "grin"
# BIG GRIN →     $ m_mouth = "biggrin"
# FROWN →        $ m_mouth = "frown"
# SAD →          $ m_mouth = "sad"
# OPEN/GASP →    $ m_mouth = "o"
# ANGRY →        $ m_mouth = "angry"
# POUTING →      $ m_mouth = "pout"
# SMIRKING →     $ m_mouth = "smirk"
# KISSY FACE →   $ m_mouth = "kissy"
# SCARED →       $ m_mouth = "scared"
# NEUTRAL →      $ m_mouth = "neutral"

default m_brow = "happy"
# SAD EYEBROWS →       $ m_brow = "sad"
# ANGRY EYEBROWS →     $ m_brow = "angry"
# ONE EYEBROW UP →     $ m_brow = "suspicious"
# HAPPY EYEBROWS →     $ m_brow = "happy"


default m_stockings = False
# to turn ON →         $ m_stockings = True

default m_choker = False
# to turn ON →         $ m_choker = True

default m_earring = True
# to turn OFF →         $ m_earring = False


##### # # # # # # # #
##### LAYERED IMAGE #
##### # # # # # # # #

layeredimage maihi_image:
    always "m_base.png"
    always "maihi_default_blink"
    always "m_mouth_[m_mouth].png"
    always "m_eyebrow_[m_brow].png"

    if m_stockings:
        "m_stockings.png"
    if m_choker:
        "m_choker.png"
    if m_earring:
        "m_earring.png"
        
    group clothes:
        attribute sleep default "m_sleep.png"
        attribute casual "m_casual.png"
        attribute fancy "m_fancy.png"

    group shoes:
        attribute sneakers default "m_sneakers.png"
        attribute boots "m_boots.png"

    always "eye_overlay.png"

    group emote:
        attribute None default Null()
        attribute angry "m_emotes_angry.png" at angry_atl
        attribute blush "m_emotes_blush.png" at blush_atl
        attribute diss "m_emotes_disappointed.png" at disappointed_atl
        attribute exclaim "m_emotes_exclaim.png" at exclaim_atl
        attribute notice "m_emotes_notice.png" at notice_atl
        attribute question "m_emotes_question.png" at question_atl

image maihi_default_blink:
    "m_eye_default.png"
    choice:
        4.5
    choice:
        2.0
    choice:
        1.5
    "maihi_blinking_atl"
    0.2
    repeat

image maihi_blinking_atl:
    "m_eye_default_1.png"
    pause 0.05
    "m_eye_default_2.png"
    pause 0.05
    "m_eye_default.png"
    pause 0.05
    "m_eye_default_4.png"
    pause 0.05
    "m_eye_default.png"

transform fullbody_pos():
    xalign 0.5 zoom 0.6 yalign 0.05

image maihi = LayeredImageProxy("maihi_image", Transform(mesh=True, alpha=1.0))
# This makes sure Maihi's sprite displays correctly when modifying the transparency eg. with dissolve/ease/linear

define m = Character("Maihi", image="maihi")

##### # # # # # # # #
##### EXAMPLE LABEL #
##### # # # # # # # #

# add 'jump maihi_example' into your script.rpy, after label start to see this in-game!

label maihi_example:

    $ m_mouth = "smile"
    $ m_brow = "happy"

    show maihi sleep at fullbody_pos with dissolve

    m "Testing, testing - allow me to show you what I can do."
    m "I'm currently wearing my sleepwear!"

    show maihi casual sneakers at fullbody_pos

    m "I'm wearing my casual clothes now"

    show maihi fancy boots at fullbody_pos

    $ m_choker = True

    m "These are my fancy clothes!"

    m "I love this choker, but I'll wear it another day"

    $ m_choker = False

    $ m_mouth = "biggrin"

    m "You can change my mouth expressions by using the right callback before the text."

    $ m_mouth = "pout"

    m "This one for example is called 'pout'."

    $ m_mouth = "smile"
    $ m_brow = "suspicious"

    m "My eyebrows can move too - I'm judging you by the look of it"

    $ m_mouth = "o"
    $ m_brow = "happy"

    show maihi exclaim at fullbody_pos

    m "Oh, I nearly forgot!"

    $ m_mouth = "grin"

    show maihi notice at fullbody_pos

    m "There's emotes available for you to expand my reactions."

    show maihi None at fullbody_pos

    m "Say, have you ever wanted to change my expression {w=1.5}{nw}"

    $ m_mouth = "kissy"

    extend "without relying on another texbox?"

    $ m_mouth = "smile"

    m "That's it for the showcase! Check Maihi.rpy to explore all of these options."

    $ m_mouth = "grin"

    m "Let's loop back to the start now!"

    hide maihi with dissolve

    pause 1.0

    jump maihi_example
