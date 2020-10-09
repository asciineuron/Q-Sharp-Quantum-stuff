namespace Quantum.QSharpApplication1 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Diagnostics;

    operation SampleQuantumRandomNumberGenerator() : Result {
        using (q = Qubit()) {
            H(q);
            return MResetZ(q);
        }
    }

    operation SampleRandomNumberInRange(max : Int) : Int {
        mutable bits = new Result[0];
        for (idxBit in 1..BitSizeI(max)) {
            set bits += [SampleQuantumRandomNumberGenerator()];
        }
        let sample = ResultArrayAsInt(bits);
        return sample > max
		    ? SampleRandomNumberInRange(max)
            | sample;
    }
    
    @EntryPoint()
    operation GetGHX() : Unit {
        using(bits = Qubit[3]) {
            Message("Initial state |000>:");
            DumpMachine();
            // getting to GHZ init state:
            X(bits[2]);
            H(bits[2]);
            CNOT(bits[2], bits[0]);
            CNOT(bits[2], bits[1]);
            // now have eq 6.28, putting through next eq 6.27:
            X(bits[2]);
            H(bits[2]);
            CNOT(bits[2], bits[1]);
            Message("Altered state:");
            DumpMachine();
            
        }

    }

    
    operation SampleRandomNumber() : Int {
        let max = 50;
        Message($"Sampling a random number between 0 and {max}: ");
        return SampleRandomNumberInRange(max);
    }

    //@EntryPoint()
    operation HelloQ () : Unit {
        Message("Hello quantum world!");
    }
}
