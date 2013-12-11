function res = filterPeak(Z, fd)
corrected_Z = transpose(Z).*exp(-1i*fd*linspace(1,length(Z),length(Z)));
res = corrected_Z;
end