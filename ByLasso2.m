diff = 0.00001;
tau = 1/10000; 
b0 = rand(1,17)';


data = load('dataset.csv');
A = data(:,1:12);
%A = [A';B']';
b = data(:,13);
x = linsolve (A,b); 
%Leave 126 cases
%Divide into folders

folderSize = 14;
folderNumber = 9;
dataSize = folderSize*folderNumber;
A = A(1:dataSize,:);


%timeseries_error_rate = zeros([1 (folderNumber-1)]);
lambda = [1/8, 1/4, 1/2, 3/4, 1, 2, 4];
error_rate_lasso = zeros([length(folderNumber-1) (length(lambda))]);
for i = 1:(folderNumber-1)
    startIndex = 1;
    endIndex = folderSize*(i-1)+folderSize;
    trainIndex = false(1,(i+1)*folderSize);
    trainIndex(startIndex:endIndex) = true;
    train_A = A(trainIndex,:);
    train_b = b(trainIndex,:);
    test_A = A(~trainIndex,:);
    test_b = b(~trainIndex,:);
    
    for j = 1:length(lambda)
        beta_hat = lasso( train_A,train_b,tau,diff,lambda(j),b0);  
        result = int8(test_A*beta_hat>0.5);
        error_rate_lasso(i,j) = sum(test_b ~= result)/folderSize;
    end
end

error_rate_lasso


%lambda = [1/8, 1/4, 1/2, 3/4, 1, 2, 4]
figure(1)
hold on
xlabel('time-series CV folder','FontSize',15)
ylabel('error rate','FontSize',15);
title('Forward-chaining CV error rate by Lasso', 'FontSize',18)
folder = 1:folderNumber-1; 
for i = 1:length(lambda)
    plot(folder, error_rate_lasso(:,i)-i*0.005)
end
legend('\lambda=1/8','\lambda=1/4', '\lambda=1/2', '\lambda=3/4', '\lambda=1', '\lambda=2','\lambda=4')
grid on
grid minor
hold off


figure(3)
hold on 
plot(timeseries_error_rate)
grid on
grid minor
hold off

