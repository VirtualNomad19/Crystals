
//----------------------------------------------------------------------
// Base64 Function with String as Result
//----------------------------------------------------------------------

function Base64StringToJSON(B64String as string)
	
	B64MemBlock as integer
	B64Length as integer
	B64EndBlockLength as integer
	B64Offset as integer
	ResultLength as integer
	ResultMemBlock as integer
	ResultString as string
	B64Byte as integer[3]
	ResultByte as integer[3]
	ResultChar as integer
	ResultIndex as integer
	
	// Convert string into memblock
	// Strings are written with a null terminator 
	// byte at the end, hence the +1
	B64Length = len(B64String)
	if B64Length = 0 then exitfunction ""
	
	// 1. String in Memblock schreiben
	B64MemBlock = createMemblock(B64Length + 1)
	setMemblockString(B64MemBlock,0,B64String)
	
	// Determine size of decoded bytes
	// 2. Padding (= / ASCII 61) am Ende korrekt zählen
	B64EndBlockLength = 0
	for B64Offset = B64Length-1 to B64Length-4 step -1    
		if getMemblockByte(B64MemBlock,B64Offset) = 61 then inc B64EndBlockLength else exit
	next B64Offset
	
	// Gesamtlänge des Ziel-Strings berechnen
	ResultLength = (B64Length/4)*3 - B64EndBlockLength
	
	// decoded bytes are stored in a memblock
	ResultMemBlock = createMemblock(ResultLength)
	
	ResultIndex = 0
	for B64Offset = 0 to B64Length-1 step 4
	
		// Standardmäßig mit Padding füllen (= / ASCII 61)
		B64Byte[0] = 61 : B64Byte[1] = 61 : B64Byte[2] = 61 : B64Byte[3] = 61
		
		if B64Offset   < B64Length then B64Byte[0] = getMemblockByte(B64MemBlock,B64Offset)
		if B64Offset+1 < B64Length then B64Byte[1] = getMemblockByte(B64MemBlock,B64Offset+1)
		if B64Offset+2 < B64Length then B64Byte[2] = getMemblockByte(B64MemBlock,B64Offset+2)
		if B64Offset+3 < B64Length then B64Byte[3] = getMemblockByte(B64MemBlock,B64Offset+3)
		
		ResultByte[0] = b64_decodeChar(B64Byte[0])
		ResultByte[1] = b64_decodeChar(B64Byte[1])
		ResultByte[2] = b64_decodeChar(B64Byte[2])
		ResultByte[3] = b64_decodeChar(B64Byte[3])
		
		// 1. Byte zusammensetzen (6 Bits von Byte 0 + 2 Bits von Byte 1)
		ResultChar = ResultByte[0] << 2 || ResultByte[1] >> 4
		setMemblockByte(ResultMemBlock,ResultIndex,ResultChar)
		
		// 2. Byte zusammensetzen (4 Bits von Byte 1 + 4 Bits von Byte 2)
		if B64Byte[2] <> 61
			inc ResultIndex
			ResultChar = ((ResultByte[1]&&0xf)<<4) || (ResultByte[2]>>2)
			setMemblockByte(ResultMemBlock,ResultIndex,ResultChar)
		endif
		
		// 3. Byte zusammensetzen (2 Bits von Byte 2 + 6 Bits von Byte 3)
		if B64Byte[3] <> 61
			inc ResultIndex
			ResultChar = ((ResultByte[2]&&0x3)<<6) || ResultByte[3]
			setMemblockByte(ResultMemBlock,ResultIndex,ResultChar)
		endif
		inc ResultIndex
	next B64Offset
	
	// Speicher aufräumen und fertigen String auslesen
	deleteMemblock(B64MemBlock)
	ResultString = GetMemblockString(ResultMemBlock, 0, ResultLength)
	deleteMemblock(ResultMemBlock)
    
endfunction ResultString

//----------------------------------------------------------------------
// Hilfsfunktion: Wandelt Base64-ASCII in echten 6-Bit-Wert um
//----------------------------------------------------------------------

function b64_decodeChar(ascii as integer)
	if ascii >= 65 and ascii <= 90  then exitfunction ascii - 65  // A-Z (0 bis 25)
	if ascii >= 97 and ascii <= 122 then exitfunction ascii - 71  // a-z (26 bis 51)
	if ascii >= 48 and ascii <= 57  then exitfunction ascii + 4   // 0-9 (52 bis 61)
	if ascii = 43 then exitfunction 62                             // +
	if ascii = 47 then exitfunction 63                             // /
	if ascii = 61 then exitfunction 0                             // = (Padding-Markierung)
endfunction 0

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------



