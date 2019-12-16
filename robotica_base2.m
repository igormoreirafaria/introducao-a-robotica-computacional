function robotica_base



 Robo=Criar_Robo([],[300 300 1],5,10);
 Robo=Criar_Robo(Robo,[500 400 1],5,10);
 Robo=Criar_Robo(Robo,[700 300 1],5,10);
 Robo=Criar_Robo(Robo,[300 700 1],5,10);
 Robo=Criar_Robo(Robo,[500 600 1],5,10);
 Robo=Criar_Robo(Robo,[700 700 1],5,10);
 
 
 
 
 Alvo=Criar_Robo([],[500 100 0],0,0);
 Alvo=Criar_Robo(Alvo,[500 900 0],0,0);
  
 Obstaculo=Criar_Robo([],[100 0 randn],0,1);
 Obstaculo=Criar_Robo(Obstaculo,[900 0 randn],0,1);
 Obstaculo=Criar_Robo(Obstaculo,[0 900 randn],0,1);
 Obstaculo=Criar_Robo(Obstaculo,[0 100 randn],0,1);
 
 
 Objeto=Criar_Robo([],[500 500 1],20,10);
 Bola=Criar_Robo([],[500 500 1],20,10);
 
  
Robo_prev=Robo;
 
for i=1:100000
    
for rob=1:length(Robo)
    
    
    %estrategia geral
    Robo_prev(rob)=Atracao(Robo(rob),Objeto,.1);
    %estrategia sem bola
    %Time azul
    if rob==1   
      Robo_prev(rob)=Atracao(Robo_prev(rob),Alvo(1),.01);
    end
    if rob==2   
     
        Robo_prev(rob)=Atracao(Robo_prev(rob),Alvo(1),.001);
    end
    %estrategia sem bola para o time vermelho
     if rob==4
    %  Ir testando  o paramtro 0001
        Robo_prev(rob)=Atracao(Robo_prev(rob),Alvo(2),.001);
     end
    if rob==5
        Robo_prev(rob)=Atracao(Robo_prev(rob),Alvo(2),.001);
    end
     if rob==6
        Robo_prev(rob)=Atracao(Robo_prev(rob),Alvo(2),.001);
     end
     
    
    for rob2=1:length(Robo)
        if rob2~=rob
            temp=Robo(rob2);
            temp.raio=20;
            Robo_prev(rob)=Repulsao(Robo_prev(rob),temp,1000);
        end
    end
        
        Obstaculo(1).pos(2)=Robo_prev(rob).pos(2);
        Robo_prev(rob)=Repulsao(Robo_prev(rob),Obstaculo(1),1000);
        Obstaculo(1).pos(2)=Objeto.pos(2);
        Objeto=Repulsao(Objeto,Obstaculo(1),1000);
        Obstaculo(1).pos(2)=Bola.pos(2);
        Bola=Repulsao(Bola,Obstaculo(1),1000);

        Obstaculo(2).pos(2)=Robo_prev(rob).pos(2);
        Robo_prev(rob)=Repulsao(Robo_prev(rob),Obstaculo(2),1000);
        Obstaculo(2).pos(2)=Objeto.pos(2);
        Objeto=Repulsao(Objeto,Obstaculo(2),1000);
        Obstaculo(2).pos(2)=Bola.pos(2);
        Bola=Repulsao(Bola,Obstaculo(2),1000);

        Obstaculo(3).pos(1)=Robo_prev(rob).pos(1);
        Robo_prev(rob)=Repulsao(Robo_prev(rob),Obstaculo(3),1000);
        Obstaculo(3).pos(1)=Objeto.pos(1);
        Objeto=Repulsao(Objeto,Obstaculo(3),1000);
        Obstaculo(3).pos(1)=Bola.pos(1);
        Bola=Repulsao(Bola,Obstaculo(3),1000);

        
        Obstaculo(4).pos(1)=Robo_prev(rob).pos(1);
        Robo_prev(rob)=Repulsao(Robo_prev(rob),Obstaculo(4),1000);
        Obstaculo(4).pos(1)=Objeto.pos(1);
        Objeto=Repulsao(Objeto,Obstaculo(4),1000);
        Obstaculo(4).pos(1)=Bola.pos(1);
        Bola=Repulsao(Bola,Obstaculo(4),1000);
       
        Bola=Repulsao(Bola,Robo(rob),1000);
        Objeto=Repulsao(Bola,Robo(rob),1000);
        Robo(rob)=Rodas(Robo_prev(rob),Robo(rob)); 
        dist(rob)=sqrt(sum((Robo(rob).pos(1:2)-Objeto.pos(1:2)).^2));
end 
  [valor,pos]=min(dist);     
  
  if (valor< Objeto.raio*4+Robo(1).raio*4) && (pos==1 || pos==2 || pos==3)
    %estrategia caso um jogador tenha bola
      Objeto=Atracao(Objeto,Alvo(2),.1);
     if pos==1
         Robo(2)=Atracao(Robo(2),Robo(1),-.2);
         Robo(3)=Atracao(Robo(3),Alvo(1),.3);
     end
     if pos==2
         Robo(1)=Atracao(Robo(1),Robo(1),-.2);
         Robo(3)=Atracao(Robo(3),Alvo(1),.3);
     end
     if pos==3
         Robo(2)=Atracao(Robo(2),Robo(1),-.2);
         Robo(1)=Atracao(Robo(1),Alvo(1),.3);
     end
     
  elseif (valor <Objeto.raio*4+Robo(1).raio*4) && (pos==4 || pos==5|| pos==6)
     %estrategia caso um jogador tenha bola 
      %estrategia para o time vermelho
      % define quando o robo esta com a bola no pe
      Objeto=Atracao(Objeto,Alvo(1),.1);
       if pos==4
         Robo(5)=Atracao(Robo(5),Robo(4),-.2);
         Robo(6)=Atracao(Robo(6),Alvo(2),.3);
     end
      if pos==5
          Robo(4)=Atracao(Robo(1),Robo(1),-.2);
          Robo(6)=Atracao(Robo(3),Alvo(1),.3);
      end
      if pos==6
          Robo(4)=Atracao(Robo(2),Robo(1),-.2);
          Robo(5)=Atracao(Robo(1),Alvo(1),.3);
      end
  end
for alv=1:2
  dist2(alv)=sqrt(sum((Alvo(alv).pos(1:2)-Objeto.pos(1:2)).^2));
end
   [valor,pos]=min(dist2); 

if valor<Objeto.raio*5 
    Bola.pos(1:2)=[500 400];
   
 Robo(1).pos=[300 300 1];
 Robo(2).pos=[500 400 1];
 Robo(3).pos=[700 300 1];
 Robo(4).pos=[300 600 1];
 Robo(5).pos=[500 700 1];
 Robo(6).pos=[700 600 1];
 
 if pos==1
        disp('Ponto para o time vermelho');
   elseif pos==2
        disp('Ponto para o time azul');
   end
end

   if mod(i,1)==0
      plot(Robo(1).desenho(1,:),Robo(1).desenho(2,:),'xb',...
      Robo(2).desenho(1,:),Robo(2).desenho(2,:),'+b',...
      Robo(3).desenho(1,:),Robo(3).desenho(2,:),'*b',...
      Robo(4).desenho(1,:),Robo(4).desenho(2,:),'xr',...
      Robo(5).desenho(1,:),Robo(5).desenho(2,:),'+r',...
      Robo(6).desenho(1,:),Robo(6).desenho(2,:),'*r',...
      Alvo(1).pos(1),Alvo(1).pos(2),'*b',...
      Alvo(2).pos(1),Alvo(2).pos(2),'*r',...
     [Obstaculo(1).pos(1) Obstaculo(1).pos(1)],[100 900],'-r',...
     [Obstaculo(2).pos(1) Obstaculo(2).pos(1)],[100 900],'-r',...
     [100 900],[Obstaculo(3).pos(2) Obstaculo(3).pos(2)],'-b',...
     [100 900],[Obstaculo(4).pos(2) Obstaculo(4).pos(2)],'-b',...
     Objeto.pos(1),Objeto.pos(2),'om');
     axis([0 1000 0 1000]);
     drawnow;
   end
 end



end

function [x,P]=kalman(x,P,F,H,Q,R,z,u)
 x=F*x;
 P=F*P*F'+Q;
 e=z-(H*x+u);
 S=H*P*H'+R;
 K=P*H'/S;
 x=x+K*e;
 P=P-K*H*P;
end

function Robo=Criar_Robo(Robo,pos,vel,raio)
%funcao para criar Robos
%  Robo=Criar_Robo
    Robo_novo.pos=[rand*100 rand*100 0];
    Robo_novo.vel=2;
    Robo_novo.raio=10;
    Robo_novo.ve=0;
    Robo_novo.vd=0;
    Robo_novo.chassi=[1 1 -1 -1;-1 1 -1 1];
    Robo_novo.desenho=Robo_novo.chassi(1,:)+Robo_novo.pos(1);
    Robo_novo.desenho(2,:)=Robo_novo.chassi(2,:)+Robo_novo.pos(2);
 %cria Robo com dados em default
 if nargin==0
   Robo=Robo_novo;
 elseif nargin==1
    if isempty(Robo)
       Robo=Robo_novo;
    else
       Robo=[Robo Robo_novo];
    end  
 elseif (nargin==2)
   Robo_novo.pos=pos;
   Robo=[Robo Robo_novo];
 elseif (nargin==3)
   Robo_novo.pos=pos;
   Robo_novo.vel=vel;
   Robo=[Robo Robo_novo];
 elseif (nargin==4)
   Robo_novo.pos=pos;
   Robo_novo.vel=vel;
   Robo_novo.raio=raio;
   Robo_novo.desenho=Robo_novo.chassi*raio;
   Robo_novo.desenho=Robo_novo.chassi(1,:)+Robo_novo.pos(1);
   Robo_novo.desenho(2,:)=Robo_novo.chassi(2,:)+Robo_novo.pos(2);
   Robo=[Robo Robo_novo];
 end
 
end


function Robo=Rodask(Robo,x)
vd=x(1);
ve=x(2);


for i=1:length(Robo)

    
Robo(i).pos(3)=Robo(i).pos(3)+(ve-vd)/Robo(i).raio*2;
Robo(i).pos(1)=Robo(i).pos(1)+(ve+vd)*cos(Robo(i).pos(3))/2;
Robo(i).pos(2)=Robo(i).pos(2)+(ve+vd)*sin(Robo(i).pos(3))/2;
 
  Rot=[cos(Robo(i).pos(3)) -sin(Robo(i).pos(3));
       sin(Robo(i).pos(3)) cos(Robo(i).pos(3))];  
  for j=1:4
    Robo(i).desenho(:,j)=Rot*Robo(i).chassi(:,j)*Robo(i).raio*2;
    
  end
  Robo(i).desenho(1,:)=Robo(i).desenho(1,:)+Robo(i).pos(1);
  Robo(i).desenho(2,:)=Robo(i).desenho(2,:)+Robo(i).pos(2);



end
end




function Robo=Rodas(Robo,Roboa)

for i=1:length(Robo)
Robo(i).vd=(Robo(i).pos(1)-Roboa(i).pos(1))*2/cos(Roboa(i).pos(3))-Robo(i).ve;
Robo(i).ve=(Robo(i).pos(2)-Roboa(i).pos(2))*2/sin(Roboa(i).pos(3))-Robo(i).vd;
Robo(i).pos(3)=Roboa(i).pos(3)+(Robo.ve-Robo.vd)/(Roboa.raio*2);    

vmax=.001;
if Robo(i).vd>vmax
  Robo(i).vd=vmax;
end
if Robo(i).vd<-vmax
 Robo(i).vd=-vmax;
end
if Robo(i).ve>vmax
 Robo(i).ve=vmax;
end
if Robo(i).ve<-vmax
 Robo(i).ve=-vmax;
end

Robo(i).pos(3)=Robo(i).pos(3)+(Robo(i).ve-Robo(i).vd)/Robo(i).raio*2;
Robo(i).pos(1)=Robo(i).pos(1)+(Robo(i).ve+Robo(i).vd)*cos(Robo(i).pos(3))/2;
Robo(i).pos(2)=Robo(i).pos(2)+(Robo(i).ve+Robo(i).vd)*sin(Robo(i).pos(3))/2;
 
  Rot=[cos(Robo(i).pos(3)) -sin(Robo(i).pos(3));
       sin(Robo(i).pos(3)) cos(Robo(i).pos(3))];  
  for j=1:4
    Robo(i).desenho(:,j)=Rot*Robo(i).chassi(:,j)*Robo(i).raio*2;
    
  end
  Robo(i).desenho(1,:)=Robo(i).desenho(1,:)+Robo(i).pos(1);
  Robo(i).desenho(2,:)=Robo(i).desenho(2,:)+Robo(i).pos(2);



end
end

function Robo=Rodas2(Robo,Roboa)

for i=1:length(Robo)
Robo(i).vd=(Robo(i).pos(1)-Roboa(i).pos(1))*2/cos(Robo(i).pos(3)+0.1)-Robo(i).ve;
Robo(i).ve=(Robo(i).pos(2)-Roboa(i).pos(2))*2/sin(Robo(i).pos(3)+0.1)-Robo(i).vd;


Robo(i).pos(3)=Robo(i).pos(3)+(Robo(i).ve-Robo(i).vd)/Robo(i).raio*2;
Robo(i).pos(1)=Robo(i).pos(1)+(Robo(i).ve+Robo(i).vd)*cos(Robo(i).pos(3))/2;
Robo(i).pos(2)=Robo(i).pos(2)+(Robo(i).ve+Robo(i).vd)*sin(Robo(i).pos(3))/2;
 
  Rot=[cos(Robo(i).pos(3)) -sin(Robo(i).pos(3));
       sin(Robo(i).pos(3)) cos(Robo(i).pos(3))];  
  for j=1:4
    Robo(i).desenho(:,j)=Rot*Robo(i).chassi(:,j)*Robo(i).raio*2;
    
  end
  Robo(i).desenho(1,:)=Robo(i).desenho(1,:)+Robo(i).pos(1);
  Robo(i).desenho(2,:)=Robo(i).desenho(2,:)+Robo(i).pos(2);



end
end








function Robo=Atracao(Robo,Alvo,k)
   %sensoriamento
   %determina distancia entre alvo e Robos
   distx=Alvo.pos(1)-Robo.pos(1);
   disty=Alvo.pos(2)-Robo.pos(2);
   dist=sqrt(distx.^2+disty.^2);
    if (nargin==2)
     %aplica o grau de atracao ao alvo
      k=0.1;
    end
   
 
   if dist < (Robo.raio + Alvo.raio)
   k=-k;
     
   end
      vx=k*distx;
      vy=k*disty;
      v=sqrt(vx^2+vy^2);
     if ~isfield(Robo,'vel')
       Robo.vel=1;
     end
     if v>Robo.vel
     %limitacao da velocidade
      vx=(Robo.vel)*(vx/v);
      vy=(Robo.vel)*(vy/v);
      v2=sqrt(vx^2+vy^2);
         %atuacao
     ant=Robo.pos;
     Robo.pos(1)=Robo.pos(1)+vx;
     Robo.pos(2)=Robo.pos(2)+vy;
     atual=Robo.pos;
     Robo.pos(3)=tan((atual(2)-ant(2))/atual(1)-ant(1));
 
     end
     
     
 
     
end
 
function Robo=Repulsao(Robo,Obstaculo,kr)

   %sensoriamento
   %determina distancia entre alvo e Robos
   distx=Robo.pos(1)-Obstaculo.pos(1);
   disty=Robo.pos(2)-Obstaculo.pos(2);
   dist=sqrt(distx.^2+disty.^2);
   %processamento
     if (nargin==2)
     %aplica o grau de atracao ao alvo
      kr=100;
     end
   
   if dist<=(Robo.raio)*4+(Obstaculo.raio)*2;
   
     
      vx=kr*distx;
      vy=kr*disty;
      v=sqrt(vx^2+vy^2);
     if ~isfield(Robo,'vel')
       Robo.vel=1;
     end
     if v>Robo.vel
     %limitacao da velocidade
      vx=(Robo.vel)*(vx/v);
      vy=(Robo.vel)*(vy/v);
      v2=sqrt(vx^2+vy^2);
     end
     
           %atuacao
     ant=Robo.pos;
     Robo.pos(1)=Robo.pos(1)+vx+randn*1e-1;
     Robo.pos(2)=Robo.pos(2)+vy+randn*1e-1;
     atual=Robo.pos;
     Robo.pos(3)=tan((atual(2)-ant(2))/atual(1)-ant(1));
     

   end
 
   
   
end
 
function Exibir_Arena(tamanho,Robo,Alvo,Obstaculo,Objeto)
 
  if  nargin>1
    vRobo=[];
    for i=1:length(Robo)
     vRobo=[vRobo; Robo(i).pos(1) Robo(i).pos(2)];  
    end
  end
     
  if nargin>2
      vAlvo=[];
    for i=1:length(Alvo)
     vAlvo=[vAlvo; Alvo(i).pos(1) Alvo(i).pos(2)];  
    end

  end
  if  nargin>3
     vObstaculo=[];
    for i=1:length(Obstaculo)
     vObstaculo=[vObstaculo; Obstaculo(i).pos(1) Obstaculo(i).pos(2)];
    end
  end  
   if  nargin>4
     vObjeto=[];
    for i=1:length(Objeto)
     vObjeto=[vObjeto; Objeto(i).pos(1) Objeto(i).pos(2)];
    end
   end  
 
 
    plot(vRobo(:,1),vRobo(:,2),'sb',vAlvo(:,1),vAlvo(:,2),'gx',vObstaculo(:,1),vObstaculo(:,2),'+r',vObjeto(:,1),vObjeto(:,2),'go');  
    axis([0 tamanho(1) 0 tamanho(2)]);
  drawnow
end


