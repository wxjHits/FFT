N = 16; % FFT Precision
A = 2^13 - 1; % Magnification

%%%%%%%%% Sine Factors %%%%%%%%%
fid = fopen('cos_data.txt','w');
for i = 0 : N-1
    a = round(A*cos(2*pi*i/N));
    fprintf(fid,'%d\n',a);
end
fclose(fid);

 
%%%%%%%%% Cosine Factors %%%%%%%%%
fid = fopen('sin_data.txt','w');
for i = 0 : N-1
    a = round(A*sin(2*pi*i/N));
    fprintf(fid,'%d\n',a);
end
fclose(fid);