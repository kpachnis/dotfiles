{-# OPTIONS_GHC -fno-warn-missing-signatures #-}

import qualified Data.Map as M
import           Graphics.X11.ExtraTypes.XF86
import           XMonad
import           XMonad.Actions.CycleWindows
import           XMonad.Actions.DynamicWorkspaces
import           XMonad.Actions.Submap
import           XMonad.Actions.UpdatePointer
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.SetWMName
import           XMonad.Hooks.UrgencyHook
import           XMonad.Layout.MultiToggle
import           XMonad.Layout.MultiToggle.Instances
import           XMonad.Layout.NoBorders
import           XMonad.Layout.PerWorkspace
import           XMonad.Layout.Renamed
import           XMonad.Layout.ResizableTile
import           XMonad.Layout.SimplestFloat
import           XMonad.Layout.Tabbed
import           XMonad.Layout.TwoPane
import           XMonad.Layout.WindowNavigation
import           XMonad.Prompt
import           XMonad.Prompt.Man
import           XMonad.Prompt.RunOrRaise
import           XMonad.Prompt.Ssh
import           XMonad.Prompt.Window
import qualified XMonad.StackSet as W
import           XMonad.Util.Cursor
import           XMonad.Util.NamedScratchpad
import           XMonad.Util.Run

myModMask :: KeyMask
myModMask = mod4Mask

myTerminal :: String
myTerminal = "x-terminal-emulator"

myFont :: String
myFont = "xft:monospace:size=11"

myFocusedBorderColor, myNormalBorderColor :: String
myFocusedBorderColor = "#3465a4"
myNormalBorderColor = "#555753"

myKeymap :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeymap XConfig {XMonad.modMask = modm} = M.fromList $
    [ ((modm,                 xK_q                   ), unsafeSpawn "if type xmonad; then for pid in $(pgrep xmobar); do kill -TERM \"$pid\"; done && xmonad --recompile && xmonad --restart; else xmessage xmonad in int \\$PATH: \"$PATH\"; fi")
    , ((modm,                 xK_p                   ), runOrRaisePrompt myXPConfig)
    , ((modm,                 xK_slash               ), windowPromptGoto myXPConfig)
    , ((modm,                 xK_u                   ), focusUrgent)

    , ((modm,                 xK_bracketleft         ), sendMessage MirrorShrink)
    , ((modm,                 xK_bracketright        ), sendMessage MirrorExpand)

    , ((modm,                 xK_Right               ), sendMessage $ Go R)
    , ((modm,                 xK_Left                ), sendMessage $ Go L)
    , ((modm,                 xK_Up                  ), sendMessage $ Go U)
    , ((modm,                 xK_Down                ), sendMessage $ Go D)
    , ((modm .|. controlMask, xK_Right               ), sendMessage $ Swap R)
    , ((modm .|. controlMask, xK_Left                ), sendMessage $ Swap L)
    , ((modm .|. controlMask, xK_Up                  ), sendMessage $ Swap U)
    , ((modm .|. controlMask, xK_Down                ), sendMessage $ Swap D)
    , ((modm .|. controlMask, xK_m                   ), sendMessage $ Toggle MIRROR)

    , ((modm .|. shiftMask,   xK_a                   ), addWorkspacePrompt myXPConfig)
    , ((modm .|. shiftMask,   xK_r                   ), renameWorkspace myXPConfig)
    , ((modm .|. shiftMask,   xK_v                   ), selectWorkspace myXPConfig)
    , ((modm,                 xK_m                   ), withWorkspace myXPConfig (windows . W.shift))

    , ((modm .|. controlMask, xK_BackSpace           ), unsafeSpawn "~/bin/lock; systemctl hibernate")

    -- multimedia keys
    , ((0,                    xF86XK_AudioPrev        ), safeSpawn "mpc" ["-q", "prev"])
    , ((0,                    xF86XK_AudioPlay        ), safeSpawn "mpc" ["-q", "toggle"])
    , ((0,                    xF86XK_AudioNext        ), safeSpawn "mpc" ["-q", "next"])
    , ((0,                    xF86XK_AudioMute        ), safeSpawn "pactl" ["set-sink-mute", "@DEFAULT_SINK@", "toggle"])
    , ((0,                    xF86XK_AudioMicMute     ), safeSpawn "pactl" ["set-source-mute", "@DEFAULT_SOURCE@", "toggle"])
    , ((0,                    xF86XK_AudioLowerVolume ), safeSpawn "pactl" ["set-sink-volume", "@DEFAULT_SINK@", "-2%"])
    , ((0,                    xF86XK_AudioRaiseVolume ), safeSpawn "pactl" ["set-sink-volume", "@DEFAULT_SINK@", "+2%"])
    , ((0,                    xF86XK_MonBrightnessDown), safeSpawn "brightnessctl" ["set", "5%-"])
    , ((0,                    xF86XK_MonBrightnessUp  ), safeSpawn "brightnessctl" ["set", "+5%"])

    , ((modm, xK_r), submap . M.fromList $
                     [ ((0, xK_j), rotUnfocusedUp)
                     , ((0, xK_k), rotUnfocusedDown)
                     ])

    -- prompts
    , ((modm, xK_a), submap . M.fromList $
                     [ ((0, xK_m), manPrompt myXPConfig)
                     , ((0, xK_s), sshPrompt myXPConfig)
                     ])

    -- run most comon used programs
    , ((modm, xK_x), submap . M.fromList $
                     [ ((0, xK_b), safeSpawnProg "x-www-browser")
                     , ((0, xK_t), safeSpawn myTerminal ["-name", "dark"])
                     , ((0, xK_l), unsafeSpawn "~/bin/lock")
                     ])

    -- scratchpads
    , ((modm, xK_s), submap . M.fromList $
                     [ ((0, xK_g), namedScratchpadAction scratchpads "ghci")
                     , ((0, xK_m), namedScratchpadAction scratchpads "mixer")
                     , ((0, xK_n), namedScratchpadAction scratchpads "notes")
                     , ((0, xK_t), namedScratchpadAction scratchpads "top")
                     , ((0, xK_w), namedScratchpadAction scratchpads "nmtui")
                     ])
    ]
    ++
    zip (zip (repeat modm) [xK_1..xK_9]) (map (withNthWorkspace W.view) [0..])
    ++
    zip (zip (repeat (modm .|. shiftMask)) [xK_1..xK_9]) (map (withNthWorkspace W.shift) [0..])

myKeys = myKeymap <+> keys defaultConfig

myLayoutHook = avoidStruts
               $ windowNavigation
               $ smartBorders
               $ mkToggle (single MIRROR)
               $ onWorkspace "web" (myTabbed ||| myFull)
               $ myTiled ||| myMirrorTiled ||| myTwoPane ||| myTabbed ||| myFloat ||| myFull

    where
      myTiled       = renamed [Replace "|"] $ ResizableTall nmaster delta frac slaves
      myMirrorTiled = renamed [Replace "-"] $ Mirror myTiled
      myTwoPane     = renamed [Replace "2"] $ TwoPane delta frac
      myTabbed      = renamed [Replace "T"] $ tabbed shrinkText myTheme
      myFloat       = renamed [Replace "F"] simplestFloat
      myFull        = renamed [Replace " "] Full

      nmaster       = 1
      delta         = 3 / 100
      frac          = 1 / 2
      slaves        = []

windowsManageHook :: ManageHook
windowsManageHook = composeAll . concat
                    $ [ [className =? c --> doCenterFloat | c <- myClassFloats]
                      , [title     =? t --> doCenterFloat | t <- myTitleFloats]
                      ]
    where
      myClassFloats = ["feh", "mpv", "XCalc", "Xfce4-power-manager-settings", "Xmessage", "Virt-viewer"]
      myTitleFloats = ["Print", "Preferences"]

myManageHook :: ManageHook
myManageHook = manageDocks <+> namedScratchpadManageHook scratchpads
               <+> windowsManageHook <+> manageHook defaultConfig

myStartupHook :: X()
myStartupHook = do
  setDefaultCursor xC_left_ptr
  safeSpawnProg "xmobar"
  setWMName "LG3D"

myLogHook :: X()
myLogHook = do
  dynamicLogString myXmobarPP >>= xmonadPropLog
  updatePointer (0.5, 0.5)(1, 1)

myXPConfig :: XPConfig
myXPConfig = defaultXPConfig
             { font = myFont
             , bgColor           = "#222222"
             , fgColor           = "#d3d7cf"
             , bgHLight          = "#222222"
             , fgHLight          = "#c4a000"
             , promptBorderWidth = 0
             , position          = Top
             , historySize       = 256
             , height            = 22
             }

myTheme :: Theme
myTheme = defaultTheme
          { activeColor         = "#3465a4"
          , inactiveColor       = "#555753"
          , urgentColor         = "#cc0000"
          , activeBorderColor   = "#3465a4"
          , inactiveBorderColor = "#555753"
          , urgentBorderColor   = "#cc0000"
          , activeTextColor     = "#d3d7cf"
          , inactiveTextColor   = "#222222"
          , urgentTextColor     = "#d3d7cf"
          , fontName            = myFont
          }

myXmobarPP :: PP
myXmobarPP = xmobarPP
             { ppCurrent = xmobarColor "#ad7fa8" ""
             , ppTitle   = xmobarColor "#d3d7cf" "" . shorten 70
             , ppHidden  = xmobarColor "#555753" ""
             , ppUrgent  = xmobarColor "#ef2929" ""
             , ppVisible = xmobarColor "#739fcf" ""
             , ppSep     = "  "
             , ppLayout  = wrap "[" "]"
             }

scratchpadSize = W.RationalRect (1/6) (1/6) (2/3) (2/3)
scratchpadFloat = customFloating scratchpadSize

scratchpads :: [NamedScratchpad]
scratchpads = [ NS "ghci" (myTerminal ++ " -title ghci -e ghci") (title =? "ghci") scratchpadFloat
              , NS "top" (myTerminal ++ " -title htop -e htop") (title =? "htop") scratchpadFloat
              , NS "nmtui" (myTerminal ++ " -title nmtui -e nmtui") (title =? "nmtui") scratchpadFloat
              , NS "notes" "gvim ~/notes.md" (title =? "notes") nonFloating
              , NS "mixer" (myTerminal ++ " -title mixer -e alsamixer") (title =? "mixer") scratchpadFloat
              ]

myConfig = withUrgencyHook NoUrgencyHook
           $ defaultConfig
           { modMask            = myModMask
           , keys               = myKeys
           , terminal           = myTerminal
           , borderWidth        = 1
           , focusedBorderColor = myFocusedBorderColor
           , normalBorderColor  = myNormalBorderColor
           , manageHook         = myManageHook
           , layoutHook         = myLayoutHook
           , logHook            = myLogHook
           , handleEventHook    = fullscreenEventHook <+> docksEventHook
           , startupHook        = myStartupHook
           }

main :: IO ()
main = xmonad myConfig
