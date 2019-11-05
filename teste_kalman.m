
%H=1;
x=sin(0:1:20);
l=length(x);
z=x+randn(1,l);

xe=(:,1)=[x(1);0;0];

P=(xe(:,1)-z(1))*(xe(:,1)-z(1))';%P esta relacionado com o erro do processo 
%e a variencia do sinal
Q=eye(length(x(:,1)'))*0;%Relacionado a provabiliade do descolocamento.
Q(3, 3)=0.0000001;
R=eye(length(z(:,1)))*1';%
F=[1];  %E a função de transição, e a  
H=[1]; %Define o que vc quer ver ... QUe coisa e essa

 for i=2:l
    [xe(:,i), P] = Kalman(xe(:,i-1), P, F, H, Q, R, z(i));
  end