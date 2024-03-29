%ADALINE Algorithm
%Daniel Rodriguez Soto
%University of Guadalajara
%09/07/2021

clear
close all
clc

n = input('Integer number of points for training for two class \n');
if numel(n)>1
    error('It is not an integer ')
end
n = round(abs(n));
% Input vectors of training data
X = [];
% Desired output vector
d = [];
for i=1:n
    X(i,1) = input('Data Class 1 in coord x (-5 to 5) \n');
    if or(X(i,1)>5,X(i,1)<-5)
        disp('Out of range')
        while(or(X(i,1)>5,X(i,1)<-5))
            X(i,1) = input('Data Class 1 in coord x (-5 to 5) \n');
        end
    end
    X(i,2) = input('Data Class 1 in coord y (-5 to 5) \n');
    if or(X(i,2)>5,X(i,2)<-5)
        disp('Out of range')
        while(or(X(i,2)>5,X(i,2)<-5))
            X(i,2) = input('Data Class 1 in coord y (-5 to 5) \n');
        end
    end
    d(i) = 1;
end
for i=n+1:n+n
    X(i,1) = input('Data Class 2 in coord x (-5 to 5) \n');
    if or(X(i,1)>5,X(i,1)<-5)
        disp('Out of range')
        while(or(X(i,1)>5,X(i,1)<-5))
            X(i,1) = input('Data Class 2 in coord x (-5 to 5) \n');
        end
    end
    X(i,2) = input('Data Class 2 in coord y (-5 to 5) \n');
    if or(X(i,2)>5,X(i,2)<-5)
        disp('Out of range')
        while(or(X(i,2)>5,X(i,2)<-5))
            X(i,2) = input('Data Class 2 in coord y (-5 to 5) \n');
        end
    end
    d(i) = -1;
end
d = d';
clc;

% Normalize data -1 t0 1
X1 = normalize(X, 'range', [-1 1]);

figure()
scatter(X1(:,1),X1(:,2),[],d,'filled')
grid on
xlim([-1.5 1.5])
ylim([-1.5 1.5])


X = [X,ones(length(d),1)];
X1 = [X1,ones(length(d),1)];

%Random initial weights and display them
wg = rand(3,1);
disp('Initial random weight vector is:');
disp(wg');

%Initialize learning rate and epochs
lr = input('Learning rate \n');
epochs = input('Number of max epochs \n');
errord = input('Number of max desired error \n');
epoc=1;

opc = input('Use ADALINE(1) or Perceptron(2) \n');
while(opc~=0)
    switch opc
        case 1
            w  = wg;
            errorplot =0;
            while(1)                
                % Training ADALINE
                error = 0;                
                for i=1:size(X1,1)                    
                    x=X1(i,:)';
                    net=w'*x;
                    % Ouput of ADALINE computed
                    f(i)=logsig(net);
                    err =(d(i)-f(i))^2;
                    error=error+err
                    errorplot(epoc)= error;
                    df  = f(i).*(1-f(i));                    
                    % Weight change using ADALINE rule
                    w=w+lr*err*df*x;                    
                    
                    
                    scatter(X1(:,1),X1(:,2),[],d,'filled')
                    grid on
                    xlim([-1.5 1.5])
                    ylim([-1.5 1.5])
                    hold on
                    xw = -1.5:0.01:1.5;
                    yw = -(w(1)/w(2))*xw - (w(3)/w(2));
                    scatter(xw,yw,'.');
                    hold off
                    drawnow
                    pause(.5)
                
                if (or(error<=errord,epochs==epoc))
                    disp('Convergence')
                    disp('Weight');
                    disp(w');
                    disp('Epochs');
                    disp(epoc);
                    disp('Errors');
                    disp(errorplot);
                    disp('Error');
                    disp(error);
                    figure ()
                    bar((1:epoc),errorplot)
                    title('Epochs vs Error ADALINE')
                    xlabel('Epochs')
                    ylabel('Error')
                    break;
                end
                end 
                if (or(error<=errord,epochs==epoc))
                   break; 
                end                
                epoc=epoc+1;
            end
        otherwise
            wp  = wg;
            kk  = 0;
            errorplot =0;
            % Training Percetron
            while(1)
                error=0;
                for i=1:size(X,1)
                    x=X(i,:)';
                    net=wp'*x;
                    % Ouput of perceptron computed
                    o(i)=sign(net);
                    err=d(i)-o(i);
                    error=error+err;
                    errorplot(kk+1)= error;
                    % Weight change using perceptron rule
                    wp=wp+lr*err*x;
                    kk=kk+1;
                    
                    scatter(X(:,1),X(:,2),[],d,'filled')
                    grid on
                    xlim([-5.5 5.5])
                    ylim([-5.5 5.5])
                    hold on
                    xwp = -5.5:0.01:5.5;
                    ywp = -(wp(1)/wp(2))*xwp - (wp(3)/wp(2));
                    scatter(xwp,ywp,'.');
                    hold off
                    drawnow
                    pause(1)
                end
                if (error==0)
                    disp('Convergence')
                    disp('Weight');
                    disp(wp');
                    disp('Epochs');
                    disp(kk);
                    disp('Errors');
                    disp(errorplot);
                    disp('Error');
                    disp(error);
                    figure ()
                    bar((1:kk),errorplot)
                    title('Epochs vs Error Percetron')
                    xlabel('Epochs')
                    ylabel('Error')
                    break;
                end
                while(epochs<kk)
                    disp('Convergence')
                    disp('Weight');
                    disp(wp');
                    disp('Epochs');
                    disp(kk);
                    disp('Errors');
                    disp(errorplot);
                    disp('Error');
                    disp(sum(errorplot^2));
                    figure ()
                    bar((1:kk),errorplot)
                    title('Epochs vs Error Percetron ')
                    xlabel('Epochs')
                    ylabel('Error')
                end
            end            
    end
    opc = input('Use ADALINE(1) ,Perceptron(2) again or Stop (0) \n');
end