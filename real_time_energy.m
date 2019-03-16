%energy

function en = real_time_energy(Sig)
    nSig = Sig / max(abs(Sig));
    en = sum(nSig.^2);
end