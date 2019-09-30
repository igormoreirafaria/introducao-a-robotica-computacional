function robotica_trabalho_1
  %usando t�cnicas do codigo robotica_base
  %fa�a o transporte de dois objetos at� o alvo
  %com os seguintes robos:
  %Robo � criado
  Robo=Criar_Robo;
  Robo=Criar_Robo(Robo,[10 10],2,10);
  Robo=Criar_Robo(Robo,[20 20],1,20);
  Robo=Criar_Robo(Robo,[0 0],1,20);


  %Objeto para ser transportado - a terceira posi��o � o angulo do objeto
  Objeto.pos=[120 100 0];
  Objeto.raio=10;
  Objeto.vel=0.1;
  Objeto(2).pos=[100 300 0];
  Objeto(2).raio=20;
  Objeto(2).vel=0.1;
  %alvo para onde o objeto deve ser deslocado
  Alvo(2).pos=[300 350 0];
  Alvo(2).raio=0;
  Alvo(1).pos=[300 100 0];
  Alvo(1).raio=0;
  %obstaculos
  Obstaculo(1).pos=[300 200 0];
  Obstaculo(1).raio=10;
  Obstaculo(2).pos=[100 100 0];
  Obstaculo(2).raio=10;
  Obstaculo(3).pos=[200 300 0];
  Obstaculo(3).raio=10;



  %variavel para contar as itera��es
  %pode ser utilizada para controlar o numero de exibi��es
  %no plot (que pode ser muito lento)
  n=0;
  while(1)
    n=n+1;

    %repulsao dos objetos para os obstaculos
    for i=1:length(Objeto)
      for j=1:length(Obstaculo)
        Objeto(i) = Repulsao( Objeto(i), Obstaculo(j), 1000 );
      end

      
      %for j=1:length(Robo)
       % Objeto(i) = Repulsao( Objeto(i), Robo(j), 1000 );
      %end

    end
  %repulsao dos robos para os obstaculos e objetos e outros robos
    for i=1:length(Robo)
      for j=1:length(Obstaculo)
        Robo(i) = Repulsao( Robo(i), Obstaculo(j), 1000 );
      end
      for j=1:length(Objeto)
        Robo(i) = Repulsao( Robo(i), Objeto(j), 1000 );
      end
      for j=i:length(Robo)
        if i~=j 
          Robo(i)=Repulsao(Robo(i),Robo(j),1000);
        end 
      end
    end

    %primeira missao - alcancar um objeto
    
    % atração para de robos para objetos
    for i=1:2
      Robo(i)=Atracao(Robo(i),Objeto(1),0.1);
      dist_obj_rob(i)=sqrt((Robo(i).pos(1)-Objeto(1).pos(1)).^2+ (Robo(i).pos(2)-Objeto(1).pos(2)).^2);  
    end

    % verifica repulsão entre robos
    for i=1:2
      for j=1:2
        if  (i~=j)
          if dist_obj_rob(i) <= Robo(i).raio+Objeto(1).raio
            Robo(i)=Repulsao(Robo(i),Robo(j),10000);
          end
        end
      end
    end
 
    % verifica a distribuição dos robos e locomoção do objeto
    dist_robo = []
    dist_robo_obj = []
    for i=1:2
      for j=i:2
        if (i~=j)
          dist_robo = [dist_robo; (Robo(i).pos(1)-Robo(j).pos(1)).^2+(Robo(i).pos(2)-Robo(j).pos(2)).^2 ]
        end
      end
      dist_robo_obj = [dist_robo_obj; (Robo(i).pos(1)-Objeto(1).pos(1)).^2+(Robo(i).pos(2)-Objeto(1).pos(2)).^2 ] 
    end

    % locomoção do objeto
    if sqrt(dist_robo(1)) < 30 && sqrt(dist_robo_obj(1)) < 30 && sqrt(dist_robo_obj(2)) < 30 
      Objeto(1)=Atracao(Objeto(1),Alvo(1),0.5); 
    end
    % atração para de robos para objetos
    for i=3:4
      Robo(i)=Atracao(Robo(i),Objeto(2),0.1);
      dist_obj_rob(i)=sqrt((Robo(i).pos(1)-Objeto(2).pos(1)).^2+ (Robo(i).pos(2)-Objeto(2).pos(2)).^2);  
    end

    % verifica repulsão entre robos
    for i=3:4
      for j=3:4
        if  (i~=j)
          if dist_obj_rob(i) <= Robo(i).raio+Objeto(2).raio
            Robo(i)=Repulsao(Robo(i),Robo(j),10000);
          end
        end
      end
    end

    % verifica a distribuição dos robos 
    dist_robo = []
    dist_robo_obj = []
    for i=3:4
      for j=i:4
        if (i~=j)
          dist_robo = [dist_robo; (Robo(i).pos(1)-Robo(j).pos(1)).^2+(Robo(i).pos(2)-Robo(j).pos(2)).^2 ]
        end
      end
      dist_robo_obj = [dist_robo_obj; (Robo(i).pos(1)-Objeto(2).pos(1)).^2+(Robo(i).pos(2)-Objeto(2).pos(2)).^2 ] 
    end

    % locomoção do objeto
    if sqrt(dist_robo(1)) < 60 && sqrt(dist_robo_obj(1)) < 60 && sqrt(dist_robo_obj(2)) < 60 
      Objeto(2)=Atracao(Objeto(2),Alvo(2),0.5); 
    end
  

    if mod(n,10)==0
      Exibir_Arena([400 400],Robo,Alvo,Obstaculo,Objeto);
    end
  end
end


function Robo=Criar_Robo(Robo,pos,vel,raio)
  %funcao para criar Robos
  %  Robo=Criar_Robo
    Robo_novo.pos=[rand*100 rand*100 0];
    Robo_novo.vel=2;
    Robo_novo.raio=10;


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
    Robo=[Robo Robo_novo];
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

  if dist^2 < (Robo.raio + Obstaculo.raio)^2
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
    Robo.pos(1)=Robo.pos(1)+vx+randn*1e-9;
    Robo.pos(2)=Robo.pos(2)+vy+randn*1e-9;
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

% ,  vObstaculo(:,1),vObstaculo(:,2),'+r'
  plot(vRobo(:,1),vRobo(:,2),'sb', 'linewidth', 10, vObstaculo(:,1), vObstaculo(:,2), '+r', 'linewidth', 10,  vAlvo(:,1),vAlvo(:,2),'yx',  'linewidth', 10,  vObjeto(:,1),vObjeto(:,2),'go', 'linewidth', 10) ;
  axis([0 tamanho(1) 0 tamanho(2)]);
  drawnow
end