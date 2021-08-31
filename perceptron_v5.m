%Perceptrons Algorithm 
%Daniel Rodriguez Soto
%University of Guadalajara 
%08/31/21

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
        error('Out of range')
    end
    X(i,2) = input('Data Class 1 in coord y (-5 to 5) \n');
    if or(X(i,1)>5,X(i,1)<-5)
        error('Out of range')
    end
    d(i) = 1;
end
for i=n+1:n+n
    X(i,1) = input('Data Class 2 in coord x (-5 to 5) \n');
    if or(X(i,1)>5,X(i,1)<-5)
        error('Out of range')
    end
    X(i,2) = input('Data Class 2 in coord y (-5 to 5) \n');
    if or(X(i,1)>5,X(i,1)<-5)
        error('Out of range')
    end
    d(i) = -1;
end

clc;

figure()
scatter(X(:,1),X(:,2),[],d,'filled')
xlim([-5.5 5.5])
ylim([-5.5 5.5])

% X = [X,ones(length(d),1)];
%Random initial weights and display them
w = rand(size(X,2),1);
disp('Initial random weight vector is:');
disp(w');


%initialise learning rate and epochs
lr = input('Learning rate \n');
epochs = input('Number of max epochs \n');

kk=0;

%Training 
while(1)
    error=0;
    for i=1:size(X,1)
        x=X(i,:)';
        net=w'*x;
        % Ouput of perceptron computed
        o(i)=sign(net);
        err=d(i)-o(i);
        error=error+err;
        % Weight change using perceptron rule
        w=w+lr*err*x;
        kk=kk+1;
        
        scatter(X(:,1),X(:,2),[],d,'filled')
        xlim([-5.5 5.5])
        ylim([-5.5 5.5])
        hold on
        xw = -5.5:0.01:5.5;
        yw = -(w(length(w)-1)/w(length(w)))*xw - (w(length(w))/w(length(w)-1));
        scatter(xw,yw,'.');
        hold off
        drawnow
        pause(0.4)
    end
    if (error==0)
        disp('Convergence')
        disp('Weight');
        disp(w');
        disp('Epochs');
        disp(epochs);
        disp('Error');
        disp(error);
        break;
    end
    while(epochs<kk)
        disp('No convergence')
        disp('Weight',w);
        disp(w);
        disp('Epochs');
        disp(epochs);
        disp('Error');
        disp(error);
        break;
    end
end
