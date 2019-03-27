//ABYX SYNTHESIZER

//DCOW (Wave Oscillator)
(
SynthDef(\dcow, {
	arg out=0, freq=100, freqRat=1.005, wave=0, pan= -1.0, gate=1,
	amp=0.5, vel=60 , attack=1, decay=1, sustain=0.5, release=1;
	var sig, freq2, env;
	freq2 = freqRat * freq;
	sig = [
		Saw.ar([freq, freq2] ),
		Pulse.ar([freq, freq2] ),
		LFTri.ar([freq, freq2] ),
		SinOsc.ar([freq, freq2] )
	];
	env = EnvGen.kr(Env.adsr(attack, decay, sustain, release), gate);
	sig = sig * env * amp * (vel/127);
		Out.ar (
		out,
		Pan2.ar(SelectX.ar(wave * 3, sig), [pan, pan * -1.0]).sum,
	);
}).send;
)


//DCOF (Noise Filtered Oscillator)
(
SynthDef(\dcof, {
	arg out=0, freq=200, amp=1, dirt=0.05, light=3000.0, gate=1,
	vel=60, attack=1, decay=1, sustain=0.5, release=1;
	var signal, freqs, env;
	freqs = Array.fill(12, {arg i; (i+1) * freq});
	signal = PinkNoise.ar(1.0);
	signal = BPF.ar(signal, freqs, dirt, amp/dirt.sqrt);
	signal = LPF.ar(signal, light);
	env = EnvGen.kr(Env.adsr(attack, decay, sustain, release), gate);
	signal = signal * env * (vel / 127);
	Out.ar(out, Splay.ar(signal.scramble));
},[0,0,0,0.5,0]).send;
)

//DCFM (Frequency Modulation Oscillator)


//DCF (24dB/oct filter)
(
SynthDef(\dcf, {
	arg out=0, in=0, freq=200, res=1;
	var signal;
	signal = In.ar(in, 2);
	signal = MoogFF.ar(signal, freq, res);
	Out.ar(out, signal);
}).send;
)

b = Bus.audio(Server.default, 2);


//LFOXY (LOW FREQUENCY OSCILLATOR X and Y)
(
SynthDef(\lfoxy, {
	arg out=0, freq=10, wave=0, depth=1.0;
	var oscil, signal;
	oscil = [
		Saw.kr(freq, depth),
		Pulse.kr(freq, depth),
		LFTri.kr(freq, depth),
		SinOsc.kr(freq, depth)
	];
	signal = SelectX.kr(wave * 3, oscil);
	Out.kr(out, signal);
}).send;
)

//ENVAB (ADSR ENVELOPPE A AND B)
(
SynthDef(\envAB, {
	arg out=0, gate=0, attack=1, decay=1, sustain=1, release=1;
	var env;
	env = EnvGen.kr(Env.adsr(attack, decay, sustain, release), gate);
	Out.kr(out, env);
}).send;
)

~dcow = Synth(\dcow);
b = Bus.audio(Server.default, 2);
~dcow.set(\out, b);
~dcf = Synth.after(x, \dcf);
~dcf.set(\in, b);
~dcf.set(\freq, 5000);

e = Synth.before(x, \lfoxy);
b = Bus.control();
x.map(\freqAdd, b);
e.set(\out, b);
e.set(\depth, 10);
x.set(\freqAdd, 0);

~dcof.set(\dirt, 0.001);