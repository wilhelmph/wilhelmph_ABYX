//Execution 1: Create Modules

~dcow = Synth(\dcow);
~dcof = Synth(\dcof);
~dcf = Synth(\dcf);
~envA = Synth(\envA);
~envB = Synth(\envB);
~lfox = Synth(\lfoxy);
~lfoy = Synth(\lfoxy);

// Execution 2: Create Audio Buses

// Execution 3: Create Control Buses

// Execution 4: Audio Mapping

// Execution 5: Control Mapping

//Buses Test

b = Bus.control();
x.map(\lfoxy, \amp);
~dcow.set(\out, b);
~dcf.set(\In, b);

//Tests audio

~dcow = Synth(\dcow);
b = Bus.audio(Server.default, 2);
~dcow.set(\out, b);
~dcf = Synth.after(x, \dcf);
~dcf.set(\in, b);
~dcf.set(\freq, {MouseX.kr(200, 3000)});
~dcf.set(\freq, 6000);


// Things

b = Bus.control();

b.scope;
b.set(2);

x = {Out.kr(b, SinOsc.kr(10));}.play;

x = {Out.kr(b, 4);}.play;

~dcow.free

~dcof.set(\attack, 0.01)