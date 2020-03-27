import System.IO
import System.Exit
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks 
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import Data.Ratio -- make ration % available
import XMonad.Layout.Spiral
import XMonad.Layout.Grid
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Util.NamedWindows
import XMonad.Util.Run
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
-- certain contrib modules.
--
-- myTerminal = "/usr/bin/gnome-terminal"
-- myTerminal = "zsh"

myTerminal = "xfce4-terminal"


------------------------------------------------------------------------
-- Window rules
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
	[
	  ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))
	, ((modMask, button2), (\w -> focus w >> windows W.swapMaster))
	, ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))
	]

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launching and killing programs
    [ 
      ((modMask .|. shiftMask, xK_p), spawn "/home/fhv/bin/select-screenshot")
    , ((modMask, xK_Escape), spawn "/home/fhv/bin/keyboard")
    , ((modMask .|. controlMask, xK_j), spawn "python /home/fhv/bin/volume.py down")
    , ((modMask .|. controlMask, xK_k), spawn "python /home/fhv/bin/volume.py up")
    , ((modMask .|. controlMask, xK_m), spawn "python /home/fhv/bin/volume.py mute")
		, ((modMask .|. controlMask, xK_l), spawn "slock")
--- DEFAULT KEYS ---
    , ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf) -- %! Launch terminal
    , ((modMask,               xK_p     ), spawn "dmenu_run") -- %! Launch dmenu
    , ((modMask .|. shiftMask, xK_c     ), kill) -- %! Close the focused window

    , ((modMask,               xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- %!  Reset the layouts on the current workspace to default

    , ((modMask,               xK_n     ), refresh) -- %! Resize viewed windows to the correct size

    -- move focus up or down the window stack
    , ((modMask,               xK_Tab   ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask .|. shiftMask, xK_Tab   ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((modMask,               xK_j     ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask,               xK_k     ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((modMask,               xK_m     ), windows W.focusMaster  ) -- %! Move focus to the master window

    -- modifying the window order
    , ((modMask,               xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window

    -- resizing the master/slave ratio
    , ((modMask,               xK_h     ), sendMessage Shrink) -- %! Shrink the master area
    , ((modMask,               xK_l     ), sendMessage Expand) -- %! Expand the master area

    -- floating layer support
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink) -- %! Push window back into tiling

    -- increase or decrease number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area

    -- quit, or restart
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) -- %! Quit xmonad
    , ((modMask              , xK_q     ), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") -- %! Restart xmonad

    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


myManageHook = composeAll
    [ className =? "Chromium"       	--> doShift "2:web"
    , className =? "Google-chrome"  	--> doShift "2:web"
		, className =? "hiri"							--> doShift "3:mail"
		, className =? "Mendeley Desktop"	--> doShift "4:article"
		, className =? "spotify"					--> doShift "5:music"
    , resource  =? "desktop_window" 	--> doIgnore
    , className =? "Galculator"     	--> doFloat
    , className =? "Gimp"           	--> doFloat
    , resource  =? "gpicview"       	--> doFloat
    , className =? "MPlayer"        	--> doFloat
    , className =? "stalonetray"    	--> doIgnore
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)]

myWorkspaces = ["1:term","2:web","3:mail","4:article","5:music", "6:code"] ++ map show [7..9]

-- myLayouts = spacing 10 $ Tall 1 (3/100) (1/2) ||| spiral (125 % 146) || Grid ||| Full
myLayouts = gaps [(U, 18)] $ spacing 2 $ Tall 1 (3/100) (1/2) ||| spiral (125 % 146) ||| Grid ||| Mirror (Tall 1 (3/100) (3/5)) ||| Full

main = do
  xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
  xmonad $ defaultConfig
    { manageHook = manageDocks <+> manageHook defaultConfig  <+> myManageHook
    , layoutHook = myLayouts
    --, layoutHook = avoidStruts $  layoutHook defaultConfig 
    , logHook = dynamicLogWithPP xmobarPP
                    { ppOutput = hPutStrLn xmproc
                    , ppTitle = xmobarColor "green" "" . shorten 50
                    }
    , terminal = myTerminal
    , modMask = mod4Mask
    , keys = myKeys
    , workspaces = myWorkspaces
    , handleEventHook = handleEventHook defaultConfig <+> docksEventHook
    , mouseBindings = myMouseBindings
    , focusFollowsMouse = myFocusFollowsMouse
    , startupHook = setWMName "LG3D"
    }
    
