diff = 0.00001;
tau = 1/10000; 

%1.score
data = load('dataset.csv');
A1 = data(:,1:12);
%A = [A';B']';
b = data(:,13);

%2.label
data2 = load('stock.csv'); 
A2 = data2(:, 2:6); 

A = [A1 A2]; 
b = data(:,13); 
dim_A = size(A);
feature_number = dim_A(2);
b0 = rand(1,feature_number)'; %initialize the beta.hat

folderSize = 14;
folderNumber = 9;
dataSize = folderSize*folderNumber;
A = A(1:dataSize,:);
b = b(1:dataSize,:); 

%timeseries_error_rate = zeros([1 (folderNumber-1)]);
lambda = [1/8, 1/4, 1/2, 3/4, 1, 2, 4];
error_rate_lasso = zeros([length(folderNumber-1) (length(lambda))]);
sparsity = zeros([length(folderNumber-1) (length(lambda))]);
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
        count_zero = size(find(beta_hat==0));
        result = int8(test_A*beta_hat>0.5);
        sparsity(i,j) = count_zero(1); 
        error_rate_lasso(i,j) = sum(test_b ~= result)/folderSize;
    end
end

error_rate_lasso
sparsity



%lambda = [ 1/8, 1/4, 1/2, 3/4, 1, 2, 4]
figure(1)
hold on
xlabel('time-series CV folder','FontSize',15)
ylabel('error rate','FontSize',15);
title('Forward-chaining CV Error Rate by Lasso', 'FontSize',18)
folder = 1:folderNumber-1; 
for i = 1:length(lambda)
    plot(folder, error_rate_lasso(:,i)-i*0.0005)
end
legend('\lambda=1/8','\lambda=1/4', '\lambda=1/2', '\lambda=3/4', '\lambda=1', '\lambda=2','\lambda=4')
grid on
grid minor
hold off


figure(2)
hold on 
xlabel('time-series CV folder','FontSize',15)
ylabel('sparsity','FontSize',15);
title('The Sparsity of Fitted Weights by Lasso', 'FontSize',18)
folder = 1:folderNumber-1; 
for i = 1:length(lambda)
    plot(folder, sparsity(:,i)/feature_number)
end
legend('\lambda=1/8','\lambda=1/4', '\lambda=1/2', '\lambda=3/4', '\lambda=1', '\lambda=2','\lambda=4')
grid on
grid minor
hold off


