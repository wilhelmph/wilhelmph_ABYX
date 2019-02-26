//ABYX SYNTHESIZER

//DCOW (Wave Oscillator)
(
SynthDef(\dcow, {
	arg out=0, freq1=100, freq2=100.5, wave=0;
	var oscil1, oscil2, signal1, signal2;
	oscil1 = [
		Saw.ar(freq1),
		Pulse.ar(freq1),
		LFTri.ar(freq1),
		SinOsc.ar(freq1)
	];
	oscil2 = [
		Saw.ar(freq2),
		Pulse.ar(freq2),
		LFTri.ar(freq2),
		SinOsc.ar(freq2)
	];
	signal1 = SelectX.ar(wave * 3, oscil1);
	signal2 = SelectX.ar(wave * 3, oscil2);
	Out.ar (out, [signal1, signal2]);
}).send;
)

//DCOF (Noise Filtered Oscillator)
(
SynthDef(\dcof, {
	arg out=0, freq=200, amp=1, dirt=1.0, light=1.0;
	var signal, freqs;
	freqs = Array.fill(12, {arg i; (i+1) * freq});
	signal = PinkNoise.ar(1.0);
	signal = BPF.ar(signal, freqs, dirt, amp/dirt.sqrt);
	Out.ar(out, Splay.ar(signal.scramble));
},[0,0,0,0.5,0]).send;
)

//LFOXY (LOW FREQUENCY OSCILLATOR X and Y)
(
SynthDef(\lfoxy, {
	arg out=0, freq= 10, wave=0;
	var oscil, signal;
	oscil = [
		Saw.kr(freq),
		Pulse.kr(freq),
		LFTri.kr(freq),
		SinOsc.kr(freq)
	];
	signal = SelectX.kr(wave * 3, oscil);
	Out.kr(out, signal);
}).send;
)

//ENVAB (ADSR ENVELOPPE A AND B)
(
SynthDef(\envAorB, {
	arg out=0, gate=0, attack=1, decay=1, sustain=1, release=1;
	var env;
	env = EnvGen.kr(Env.adsr(attack, decay, sustain, release), gate);
	Out.kr(out, env);
}).send;
)





