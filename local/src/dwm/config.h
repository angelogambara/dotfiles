static char lockfile[] = "/tmp/dwm.lock";
static char dmenumon[] = "0";
static const char *fonts[] = { "monospace:size=10" };
static const char dmenu_fn[] = "monospace:size=10" ;
static const char dmenu_nb[] = "#323232";
static const char dmenu_nf[] = "#ffffff";
static const char dmenu_sb[] = "#005577";
static const char dmenu_sf[] = "#ffffff";

static const char *spawncmd[] = { "alacritty", NULL };
static const char *dmenucmd[] = { "dmenu_run",
	"-fn", dmenu_fn,
	"-nb", dmenu_nb,
	"-nf", dmenu_nf,
	"-sb", dmenu_sb,
	"-sf", dmenu_sf, NULL
};

static const char *colors[][3] = {
	[SchemeOne] = { dmenu_nf, dmenu_nb, dmenu_nb },
	[SchemeTwo] = { dmenu_sf, dmenu_sb, dmenu_sf },
};

static const char *tags[] = {
	"1", "2", "3",
	"4", "5", "6",
	"7", "8", "9",
};

static const unsigned int snap = 32;
static const unsigned int borderpx = 1;
static const int topbar = 1;
static const int showbar = 1;
static const int resizehints = 1;
static const int nmaster = 1;
static const int lockfullscreen = 1;
static const float mfact = 0.55;

static const Rule rules[] = {
	{ "mpv", NULL, NULL, 0, 1, -1 },
};

static const Layout layouts[] = {
	{ "[]=", tile },
	{ "><>", NULL },
	{ "[M]", monocle },
};

#include "movestack.c"
#include "shiftview.c"

#define COMMAND(CMD) {.v = (const char*[]) { "sh", "-c", CMD, NULL } }
#define TAGKEYS(KEY,TAG) \
	{ Mod4Mask,                       KEY, view,       {.ui = 1 << TAG} }, \
	{ Mod4Mask|ControlMask,           KEY, toggleview, {.ui = 1 << TAG} }, \
	{ Mod4Mask|ShiftMask,             KEY, tag,        {.ui = 1 << TAG} }, \
	{ Mod4Mask|ControlMask|ShiftMask, KEY, toggletag,  {.ui = 1 << TAG} },

static const Key keys[] = {
	{ Mod4Mask,           XK_space, setlayout,      {0} },
	{ Mod4Mask|ShiftMask, XK_space, togglefloating, {0} },

	{ Mod4Mask,           XK_Return, zoom, {0} },
	{ Mod4Mask|ShiftMask, XK_Return, view, {0} },

	{ Mod4Mask,           XK_Tab, shiftview, {.i = +1 } },
	{ Mod4Mask|ShiftMask, XK_Tab, shiftview, {.i = -1 } },

	{ Mod4Mask,           XK_p, spawn, {.v = dmenucmd } },
	{ Mod4Mask|ShiftMask, XK_p, spawn, {.v = spawncmd } },

	{ Mod4Mask,           XK_q, killclient, {0} },
	{ Mod4Mask|ShiftMask, XK_q, quit,       {0} },

	{ Mod4Mask,           XK_0, view, {.ui = ~0 } },
	{ Mod4Mask|ShiftMask, XK_0, tag,  {.ui = ~0 } },

	{ Mod4Mask, XK_d, spawn, COMMAND("sleep 1; xset dpms force off") },
	{ Mod4Mask, XK_s, spawn, COMMAND("sxiv -ro tatenaga/ yokonaga/") },

	TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2)
	TAGKEYS(XK_4, 3) TAGKEYS(XK_5, 4) TAGKEYS(XK_6, 5)
	TAGKEYS(XK_7, 6) TAGKEYS(XK_8, 7) TAGKEYS(XK_9, 8)

	{ Mod4Mask, XK_less, spawn, COMMAND("pactl set-sink-volume @DEFAULT_SINK@ -3%") },
	{ Mod4Mask|ControlMask|ShiftMask, XK_less, spawn, COMMAND("pactl set-sink-mute @DEFAULT_SINK@ toggle") },
	{ Mod4Mask|ShiftMask, XK_less, spawn, COMMAND("pactl set-sink-volume @DEFAULT_SINK@ +3%") },

	{ Mod4Mask, XK_f, setlayout, {.v = &layouts[1]} },
	{ Mod4Mask, XK_m, setlayout, {.v = &layouts[2]} },
	{ Mod4Mask, XK_t, setlayout, {.v = &layouts[0]} },

	{ Mod4Mask, XK_h, setmfact, {.f = -.05 } },
	{ Mod4Mask, XK_l, setmfact, {.f = +.05 } },

	{ Mod4Mask|ShiftMask, XK_h, incnmaster, {.i = -1 } },
	{ Mod4Mask|ShiftMask, XK_l, incnmaster, {.i = +1 } },

	{ Mod4Mask, XK_j, focusstack, {.i = +1 } },
	{ Mod4Mask, XK_k, focusstack, {.i = -1 } },

	{ Mod4Mask|ShiftMask, XK_j, movestack, {.i = +01 } },
	{ Mod4Mask|ShiftMask, XK_k, movestack, {.i = -01 } },

	{ Mod4Mask, XK_comma,  focusmon, {.i = -1 } },
	{ Mod4Mask, XK_period, focusmon, {.i = +1 } },

	{ Mod4Mask|ShiftMask, XK_comma,  tagmon, {.i = -1 } },
	{ Mod4Mask|ShiftMask, XK_period, tagmon, {.i = +1 } },
};

static const Button buttons[] = {
	{ ClkLtSymbol, 0, Button1, setlayout, {0} },
	{ ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]} },

	{ ClkWinTitle,   0, Button2, zoom,  {0} },
	{ ClkStatusText, 0, Button2, spawn, {.v = spawncmd } },

	{ ClkClientWin, Mod4Mask, Button1, movemouse,      {0} },
	{ ClkClientWin, Mod4Mask, Button2, togglefloating, {0} },
	{ ClkClientWin, Mod4Mask, Button3, resizemouse,    {0} },

	{ ClkTagBar, 0, Button1, view,       {0} },
	{ ClkTagBar, 0, Button3, toggleview, {0} },

	{ ClkTagBar, Mod4Mask, Button1, tag,       {0} },
	{ ClkTagBar, Mod4Mask, Button3, toggletag, {0} },
};
