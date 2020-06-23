#include <sourcemod>
#include <sdktools>
#include <sdktools_functions>

#pragma semicolon 1

public Plugin:myinfo =
{
	name = "[Warmode] Hint Scores",
	author = "Kushal",
	description = "Prints Scores On Warmod",
	version = "1.1",
	url = ""
}

ConVar g_CTScore;
ConVar g_TScore;
ConVar g_WarStatus;

new tScore;
new ctScore;
new status;


public OnAllPluginsLoaded()
{
	CreateTimer(2.0, Command_Score, _, TIMER_REPEAT);
	HookConVarChange(FindConVar("wm_status"), OnStatusEnd);
}

public Action:Command_Score(Handle:timer)
{
	g_CTScore = FindConVar("wm_ct_score");
	ctScore = GetConVarInt(g_CTScore);
	
	g_TScore = FindConVar("wm_t_score");
	tScore = GetConVarInt(g_TScore);
	
	g_WarStatus = FindConVar("wm_status");
	status = GetConVarInt(g_WarStatus);
	
	if (status == 0)
	{
		PrintHintTextToAll("Waiting For Match. Type !fs to Force Start", ctScore, tScore);
	}
	else if (status > 4)
	{
		if (ctScore > tScore)
		{
		PrintHintTextToAll(" Score \n CT : %d\nT : %d", ctScore, tScore);
		}
		else
		{
		PrintHintTextToAll(" Score \n T : %d\nCT : %d", tScore, ctScore);
		}	
	}
}

public OnStatusEnd(ConVar convar, char[] oldValue, char[] newValue)
{
	g_CTScore = FindConVar("wm_ct_score");
	ctScore = GetConVarInt(g_CTScore);
	
	g_TScore = FindConVar("wm_t_score");
	tScore = GetConVarInt(g_TScore);
	
	g_WarStatus = FindConVar("wm_status");
	status = GetConVarInt(g_WarStatus);
	
	int totalScore = tScore + ctScore;
	
	if (totalScore == 15  && status > 5)
	{
		ServerCommand("sm_tsay green !!--=== HALF TIME ===--!!");
		ServerCommand("sm_play @all razzr/wartools/halftime.mp3");
	}
}
