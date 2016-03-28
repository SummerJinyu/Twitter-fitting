function [ w2 ] = SVM1( X, y, penalty, n, m)
%Basic setting
gamma = 0.01;
T = 20000;
count = 0; %check

%Initialize beta 
w2 = zeros([n+1 1]);%one more dimension for intercept 
w1 = w2 + 1;

%Fitting: 
for k = 1:T
    k;
    w1 = w2;  %kth iteration
    gradient = 0;
    for i = 1:m  %for each observation 126
        if (y(i)*X(i,:)*w1 <= 1)
            %soft threshreshold
            hi_y = y(i);
            hi_X = X(i,:)';
            hi = -y(i)*X(i,:)';
            count = count+1;
            gradient = gradient + (-y(i)*X(i,:)'); 
        end
    end
    for i = 1:n
        gradient(i) = gradient(i) + penalty*2*(w1(i));
    end
    %the updated (k+1) iteration
    w2 = w1 - gamma*gradient; 
end


