// MIDI Good
MIDIClient.init;
MIDIIn.connectAll;

(
MIDIdef.noteOn(\MIDIOn, {
	arg vel, note, chan, src;
	[vel, note].postln;
	~dcow.set(\freq, note.midicps);
	~dcow.set(\gate, 1);
	~dcow.set(\vel, vel);

	~dcof.set(\freq, note.midicps);
	~dcof.set(\gate, 1);
	~dcof.set(\vel, vel);
});
)

(
MIDIdef.noteOff(\MIDIOff, {
	arg vel, note;
	[vel, note].postln;
	~dcow.set(\gate, 0);
	~dcof.set(\gate, 0);
});
)
