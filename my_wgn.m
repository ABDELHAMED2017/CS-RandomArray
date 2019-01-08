function noise = my_wgn(SNR,signal_power,num_row,num_column)
    reqSNR = 10^(SNR/10);
    noisePower = signal_power/reqSNR;
    noise = sqrt(noisePower/2) * (randn(num_row,num_column) + 1i*randn(num_row,num_column));
end