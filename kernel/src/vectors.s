.section ".text.vectors"
.global vectors

vectors:
    b reset
    b undefined_instruction
    b software_interrupt
    b prefetch_abort
    b data_abort
    nop // Placeholder for address exception vector
    b irq
    b fiq
