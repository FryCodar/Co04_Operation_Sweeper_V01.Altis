#define TAG MSOT

#define QUOTE(var1) #var1
#define DOUBLES(var1,var2) ##var1##_##var2
#define TRIPLES(var1,var2,var3) ##var1##_##var2##_##var3
#define DP_DOUBLES(var1,var2) ##var1##____##var2

#define TAGADD DOUBLES(TAG,COMPONENT)

#define MFUNC(var1,var2) TRIPLES(DOUBLES(TAG,var1),fnc,var2)  //Mission Functions (Module Cross)
#define BFUNC(var1) TRIPLES(BIS,fnc,var1)   //BIS Function
#define CFUNC(var1) TRIPLES(CBA,fnc,var1)   //CBA Function
#define AFUNC(var1,var2) TRIPLES(DOUBLES(ACE,var1),fnc,var2) //ACE Functions


#define STR_MFUNC(var1,var2) TRIPLES('DOUBLES(TAG,var1),fnc,var2') //Mission Functions as String
#define STR_BFUNC(var1) TRIPLES('BIS,fnc,var1') // BIS Functions as String
#define STR_CFUNC(var1) TRIPLES('CBA,fnc,var1') // CBA Functions as String



#define STRVAR_TR(var1,var2) QUOTE(TRIPLES(TAG,var1,var2))
#define STRVAR_TC(var1) QUOTE(TRIPLES(TAG,COMPONENT,var1))
#define STRVAR_DO(var1) QUOTE(DOUBLES(TAG,var1))


//remote execute macros
// TODO check
//<params> remoteExecCall [<function>,(<target>,<isPersistent>)];

#define REMOTE_TRIEXECM(paramets,modul,function,device) paramets remoteExecCall [STR_MFUNC(modul,function), device]
#define REMOTE_TRIEXESM(paramets,modul,function,device) paramets remoteExec [STR_MFUNC(modul,function), device]

#define REMOTE_NOREXESM(paramets,function,device) paramets remoteExec [QUOTE(function), device]

//REMOTE_JIP

#define REMOTE_JIP_TRIEXECM(paramets,modul,function,device) paramets remoteExecCall [STR_MFUNC(modul,function), device,true]
#define REMOTE_JIP_TRIEXESM(paramets,modul,function,device) paramets remoteExec [STR_MFUNC(modul,function), device,true]


#define MSOT_isHC (!hasInterface && !isDedicated)
#define MSOT_isPL (hasInterface)
#define MSOT_isSE (isServer)
#define MSOT_isDE (isDedicated)
#define MSOT_isMP (isMultiplayer)

#define LOG_BASE(info1,message) diag_log format[QUOTE(DP_DOUBLES(info1,COMPONENT): %1),message]
#define LOG_ERR(message) LOG_BASE('ERROR',message)
#define LOG_WARN(message) LOG_BASE('WARNING',message)

#define GET_POSNOR(var1) getPos var1
#define GET_POSATL(var1) getPosATL var1
#define GET_POSASL(var1) getPosASL var1
#define GET_DIR(var1) getDir var1
#define GET_DIRPOS(var1,var2) var1 getDir var2

#define SET_POSNOR(var1,var2,num1) var1 setPos [(var2 select 0),(var2 select 1),((var2 select 2) + num1)]
#define SET_POSATL(var1,var2,num1) var1 setPosATL [(var2 select 0),(var2 select 1),((var2 select 2) + num1)]
#define SET_POSATLM(var1,var2,num1) var1 setPosATL [(var2 select 0),(var2 select 1),((var2 select 2) - num1)]
#define SET_POSASL(var1,var2,num1) var1 setPosASL [(var2 select 0),(var2 select 1),((var2 select 2) + num1)]
#define SET_DIR(var1,num1) var1 setDir num1

#define ARR_ADDVAR(arr1,var1) arr1 pushBack var1
#define ARR_ADDARR(arr1,arr2) arr1 append arr2
#define ARR_MINARR(arr1,arr2) arr1 - arr2
#define ARR_MINIDX(arr1,num1) arr1 deleteAt num1
#define ARR_SET(arr1,num1,inarr1) arr1 set [num1,inarr1]

#define CREA_GROUP(var1) createGroup var1

#define F_LOOP(var1,num1,num2) for QUOTE(var1) from num1 to num2 do
