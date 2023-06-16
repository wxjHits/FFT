%随机生成仿真输入数据
N=16384;
QUANTI_BIT = 16 ;%16bit有符号数

kn = 0:1:N-1;

input_real = ceil((2*rand(1,N)-1)*2^(QUANTI_BIT-2));%rand()是生成（0，1）之间的随机数
input_img  = ceil((2*rand(1,N)-1)*2^(QUANTI_BIT-2));%需要注意的是该处数据不能是QUANTI_BIT-1,否则硬件仿真的结果不正确（硬件没有在16bit有符号基础上进行位宽扩展）
% input_real = unifrnd(-2,2,1,N)
x = linspace(0,0,N);
for n = 1:N
    x(n) = input_real(n)+(input_img(n))*j;
end
X = fft(x,N);
display(X/N);

file_input_real = fopen('input_real.txt','wt');
file_input_img = fopen('input_img.txt','wt');
    for k = 1:N
        s_real = input_real(k);
        if s_real>32670
            s_real=s_real-1;
        elseif s_real<0 %负数取补码
            s_real = s_real + 2^QUANTI_BIT;
        end
        ss_real = dec2hex(s_real,log2(QUANTI_BIT));%必须为整数

        s_img = input_img(k);
        if s_img>0
            s_img=s_img-1;
        elseif s_img<0 %负数取补码
            s_img = s_img + 2^QUANTI_BIT;
        end
        ss_img = dec2hex(s_img,log2(QUANTI_BIT));

        if k == N
            fprintf(file_input_real, '%s\n',ss_real);      %数据写入
            fprintf(file_input_img, '%s\n',ss_img);      %数据写入
        else
            fprintf(file_input_real, '%s\n',ss_real);      %数据写入
            fprintf(file_input_img, '%s\n',ss_img);      %数据写入
        end
    end
fclose(file_input_real);
fclose(file_input_img);