ICARUS=iverilog
SRCDIR=../src
TOPNAME=RgbVideo
SOURCES= ${SRCDIR}/${TOPNAME}_tb.v \
		${SRCDIR}/${TOPNAME}.v \
		${SRCDIR}/HVSync.v

${TOPNAME}_tb.vvp: ${SOURCES}
	${ICARUS} -o $@ ${SOURCES}

mrproper:
	-rm ${TOPNAME}_tb.vvp
