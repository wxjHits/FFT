% FFT旋转因子的生成
N=16384;
QUANTI_BIT = 16 ;%16bit有符号数进行量化

kn = 0:1:N-1;

w_real = cos(-2*pi*kn/N);
w_img  = sin(-2*pi*kn/N);

%量化，向下取整数
w_real_d = ceil(w_real*2^(QUANTI_BIT-1));
w_img_d  = ceil(w_img*2^(QUANTI_BIT-1));

file_tw_real = fopen('tw_real.txt','wt');
file_tw_img = fopen('tw_img.txt','wt');
    for i = 1:N
        s_real = w_real_d(i);
        if s_real>0
            s_real=s_real-1;
        end
        if s_real<0 %负数取补码
            s_real = s_real + 2^QUANTI_BIT;
        end
        ss_real = dec2hex(s_real,log2(QUANTI_BIT));

        s_img = w_img_d(i);
        if s_img>0
            s_img=s_img-1;
        end
        if s_img<0 %负数取补码
            s_img = s_img + 2^QUANTI_BIT;
        end
        ss_img = dec2hex(s_img,log2(QUANTI_BIT));

        if i == N
            fprintf(file_tw_real, '%s\n',ss_real);      %数据写入
            fprintf(file_tw_img, '%s\n',ss_img);      %数据写入
        else
            fprintf(file_tw_real, '%s\n',ss_real);      %数据写入
            fprintf(file_tw_img, '%s\n',ss_img);      %数据写入
        end
    end
fclose(file_tw_real);
fclose(file_tw_img);
