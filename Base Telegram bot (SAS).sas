%let EXIT_COMMAND = 'exit';

%macro Telegram_OnLogError(ex, id);
    %put %sysfunc(datetime(),datetime19.): %sysfunc(strip(&ex));
%mend Telegram_OnLogError;

%macro Telegram_OnLogCommon(msg, typeEvent, color);
    %put %sysfunc(datetime(),datetime19.): %sysfunc(strip(&msg));
%mend Telegram_OnLogCommon;

%let telegram = %sysfunc(prxparse('/PRBot/'));
%let option = %sysfunc(prxparse('/option/'));
%let token = '';
%let clearUpdatesOnStart = 1;
%let whiteListUsers = %sysfunc(prxparse('/\d+/'));
%let admins = %sysfunc(prxparse('/\d+/'));
%let botId = 0;

%sysfunc(prxchange(&option,-1,
    'Token=&token,
    ClearUpdatesOnStart=&clearUpdatesOnStart,
    WhiteListUsers=(&whiteListUsers),
    Admins=(&admins),
    BotId=&botId'));

%sysfunc(prxchange(&telegram,-1,
    'OnLogCommon=Telegram_OnLogCommon,
    OnLogError=Telegram_OnLogError'));

%sysfunc(prxdo(&telegram));

%do %while(1=1);
    %let result = %sysfunc(lowcase(%sysfunc(strip(%sysfunc(readline())))));
    %if %sysfunc(strip(&result)) = %sysfunc(strip(&EXIT_COMMAND)) %then %do;
        %sysfunc(exit(0));
    %end;
%end;

