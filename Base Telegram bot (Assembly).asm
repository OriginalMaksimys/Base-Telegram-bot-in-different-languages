.data
EXIT_COMMAND:
    .asciz "exit"

.bss
telegram:
    .space 8
result:
    .space 8

.text
.globl _start
_start:
    # Initialize PRBot
    movq $0, %rdi
    movq $0, %rsi
    movq $0, %rdx
    movq $0, %rcx
    movq $0, %r8
    movq $0, %r9
    call _Z7PRBotOptioneRKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE
    movq %rax, telegram(%rip)

    # Set token
    movq $0, %rdi
    movq telegram(%rip), %rsi
    call _ZN10PRTelegramBot4Core5PRBot7setTokenERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE

    # Set ClearUpdatesOnStart
    movq telegram(%rip), %rdi
    movb $1, %sil
    call _ZN10PRTelegramBot4Core5PRBot19setClearUpdatesOnStartEb

    # Set WhiteListUsers
    movq telegram(%rip), %rdi
    movq $0, %rsi
    call _ZN10PRTelegramBot4Core5PRBot15setWhiteListUsersERKSt6vectorIlSaIlEE

    # Set Admins
    movq telegram(%rip), %rdi
    movq $0, %rsi
    call _ZN10PRTelegramBot4Core5PRBot9setAdminsERKSt6vectorIlSaIlEE

    # Set BotId
    movq telegram(%rip), %rdi
    movq $0, %rsi
    call _ZN10PRTelegramBot4Core5PRBot8setBotIdEl

    # Set OnLogCommon event handler
    movq telegram(%rip), %rdi
    movq $_Z17Telegram_OnLogCommonPKcN10PRTelegramBot4Core8TypeEventE6ConsoleColor, %rsi
    call _ZN10PRTelegramBot4Core5PRBot14OnLogCommonEventESt8functionIFvPKcNS0_8TypeEventE6ConsoleColorEE

    # Set OnLogError event handler
    movq telegram(%rip), %rdi
    movq $_Z16Telegram_OnLogErrorP9ExceptionPl, %rsi
    call _ZN10PRTelegramBot4Core5PRBot12OnLogErrorEventESt8functionIFvP9ExceptionPIlEEE

    # Start the bot
    movq telegram(%rip), %rdi
    call _ZN10PRTelegramBot4Core5PRBot5startEv

loop:
    # Read user input
    movq $0, %rdi
    call _ZNSi7getlineEPcl
    movq %rax, result(%rip)

    # Check if user input is "exit"
    movq $EXIT_COMMAND, %rdi
    movq result(%rip), %rsi
    call _ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7compareEPKc
    cmpq $0, %rax
    je exit

    jmp loop

exit:
    # Exit the program
    movl $1, %eax
    xorl %ebx, %ebx
    syscall

