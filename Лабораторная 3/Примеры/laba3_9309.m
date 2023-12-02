clc;
clear;
dt=0.001;
N=20;
t=0:dt:(N-1)*dt;

c1=2.1;
c2=-0.2;
c3=0.5;
F1=50;
F2=400;
M=5;


x=c1*5*sin(2*pi*F1*t)+c2*3*cos(2*pi*F2*t)+c3*rand(1, N);
h=((1:M)').^(-2);
L=M+N-1;

tic;
y4=conv(h,x);
t4=toc;

tic;
X=fft(x,L); 
H=fft(h,L); 
%Y=H*X; 
Y=X.*H';
y2=real(ifft(Y));
t2=toc;

tic;
x(L)=0;
y3=filter(h,1,x);
t3=toc;

tic;
h(L)=0;
y1=zeros(1,L);
for i=1:L
    for j=1:L
        if j<=i
            y1(i)=y1(i)+h(j)*x(i-j+1); 
        else
        end; 
    end;
end
t1=toc;

l=1:1:L;
subplot(221), plot(l,y1,'g'),  title('y1');
subplot(222), plot(l,y2,'g'), title('y2');
subplot(223), plot(l,y3,'g'),  title('y3');
subplot(224), plot(l,y4,'g'), title('y4');
%y=[y1, y2, y3, y4];
time=[t1, t2, t3, t4]