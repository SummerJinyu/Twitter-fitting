diff = 0.00001;
tau = 1/10000; 

%1.score
data = load('dataset.csv');
A1 = data(:,1:12);
%A = [A';B']';

%2.label
data2 = load('stock.csv'); 
A2 = data2(:, 2:6); 

A = [A1 A2]; 
y = data(:,13); 
dim_A = size(A);
feature_number = dim_A(2);
%b0 = rand(1,feature_number)'; %initialize the beta.hat

folderSize = 14;
folderNumber = 9;
dataSize = folderSize*folderNumber;
A = A(1:dataSize,:);
y = y(1:dataSize,:); 


%timeseries_error_rate = zeros([1 (folderNumber-1)]);
lambda = [1/8, 1/4, 1/2, 3/4, 1, 2, 4];
error_rate_ridge = zeros([length(folderNumber-1) (length(lambda))]);
for i = 1:(folderNumber-1)
    startIndex = 1;
    endIndex = folderSize*(i-1)+folderSize;
    trainIndex = false(1,(i+1)*folderSize);
    trainIndex(startIndex:endIndex) = true;
    train_A = A(trainIndex,:);
    train_b = y(trainIndex,:);
    test_A = A(~trainIndex,:);
    test_b = y(~trainIndex,:);
    
    
    for j = 1:length(lambda)
       % beta_hat = ridge( train_A,train_b,tau,diff,lambda(j),b0);  
        beta_hat = ridge2( train_A, train_b, lambda(j));
        result = int8(test_A*beta_hat>0.5);
        error_rate_ridge(i,j) = sum(test_b ~= result)/folderSize;
    end
end
error_rate_ridge


%lambda = [ 1/8, 1/4, 1/2, 3/4, 1, 2, 4]
figure(3)
hold on
xlabel('time-series CV folder','FontSize',15)
ylabel('error rate','FontSize',15);
title('Forward-chaining CV Error Rate by Ridge', 'FontSize',18)
folder = 1:folderNumber-1; 
for i = 1:length(lambda)
    plot(folder, error_rate_ridge(:,i)-i*0.0005)
end
legend('\lambda=1/8','\lambda=1/4', '\lambda=1/2', '\lambda=3/4', '\lambda=1', '\lambda=2','\lambda=4')
grid on
grid minor
hold off


figure(4)
hold on
xlabel('time-series CV folder','FontSize',15)
ylabel('error rate','FontSize',15);
ylim([0.1 0.8])
title('Forward-chaining CV Error Rate by LS', 'FontSize',18)
folder = 1:folderNumber-1; 
plot(folder, timeseries_error_rate)
grid on
grid minor
hold off


