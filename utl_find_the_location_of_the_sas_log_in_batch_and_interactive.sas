Find the location of the SAS log in batch and interactive

by
Bartosz Jablonski
yabwon@gmail.com

github
https://tinyurl.com/yc8bcdns
https://github.com/rogerjdeangelis/utl_find_the_location_of_the_sas_log_in_batch_and_interactive


I see that SYSPRINTTOLOG stores only
the current redirection (if redirected), so - it is null when LOG=LOG.

For posterity, I note that this macro variable is only available (on all platforms)
since 9.4 M3 as per this thread:

see
https://communities.sas.com/t5/General-SAS-Programming/Log-Path/td-p/406362/page/2


/* run it both in interactive session and in batch mode, to see the difference */
/* PROC PRINTTO */
proc printto;
run;

%put *1*%superq(SYSPRINTTOLIST)**;
%put *1*%superq(SYSPRINTTOLOG)**;
%put *1*%qsysfunc(getoption(LOG))**; /* in batch mode*/

proc printto
print = "C:\SAS_WORK\ALTLOG\PRINTTO_OUTPUT.TXT"
log = "C:\SAS_WORK\ALTLOG\PRINTTO_LOG.TXT"
NEW
;
run;


%put *2*%superq(SYSPRINTTOLIST)**;
%put *2*%superq(SYSPRINTTOLOG)**;
%put *2*%qsysfunc(getoption(LOG))**;

data x;
a=1; output;
a=2; output;
a=3; output;
a=4; output;
a=5; output;
a=6; output;
run;

%put *3*%superq(SYSPRINTTOLIST)**;
%put *3*%superq(SYSPRINTTOLOG)**;
%put *3*%qsysfunc(getoption(LOG))**;

proc sql;
select sum(a) as sum_a
, avg(a) as avg_a
from
x
;
quit;

%put *4*%superq(SYSPRINTTOLIST)**;
%put *4*%superq(SYSPRINTTOLOG)**;
%put *4*%qsysfunc(getoption(LOG))**;


proc printto print = print log = log;
run;

%put *5*%superq(SYSPRINTTOLIST)**;
%put *5*%superq(SYSPRINTTOLOG)**;
%put *5*%qsysfunc(getoption(LOG))**;

data _null_;
run;

%put *6*%superq(SYSPRINTTOLIST)**;
%put *6*%superq(SYSPRINTTOLOG)**;
%put *6*%qsysfunc(getoption(LOG))**;




