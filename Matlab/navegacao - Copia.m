clear; clc; close all;

fprintf('\nAperte A para começar ');
st = getkey;

%O manipulador deve ir a posição inicial

if (st == 97)
    fprintf('\nStart');
end

while (st == 97)
    sprintf('-------------------------------------\nMenu Principal:\nEscolha dentre as seguintes opções:\nA para o eixo x\nB para o eixo y\nC para o eixo z\nD para sair\n-------------------------------------')
    ei= getkey;
    switch ei
        case 97
            sprintf('-------------------------------------\nMenu Secundario:\nEscolha dentre as seguintes opções:\nA 5 cm\nB -5cm\nC Retorna ao menu Principal\nD para sair\n-------------------------------------')
             se=getkey;
             switch se
                 case 97
                     fprintf('FRONT')
                 case 98
                     fprintf('BACK')
                 case 99
                     st = 97;
                 case 100
                     st = 0;
             end
        case 98
            sprintf('-------------------------------------\nMenu Secundario:\nEscolha dentre as seguintes opções:\nA 5 cm\nB -5cm\nC Retorna ao menu Principal\nD para sair\n-------------------------------------')
            se=getkey;
            switch se
                case 97
                    fprintf('RIGHT')
                case 98
                    fprintf('LEFT')
                case 99
                    st = 97;
                case 100
                    st = 0;
            end
        case 99
             sprintf('-------------------------------------\nMenu Secundario:\nEscolha dentre as seguintes opções:\nA 5 cm\nB -5cm\nC Retorna ao menu Principal\nD para sair\n-------------------------------------')
              se=getkey;
             switch se
                 case 97
                     fprintf('UP')
                 case 98
                     fprintf('DOWN')
                 case 99
                     st = 97;
                 case 100
                     st = 0;
            end
        case 100
            st = 0;
    end
                    
            
end

disp('FIM')
