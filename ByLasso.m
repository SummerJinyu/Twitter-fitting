diff = 0.00001;
tau = 1/10000; 
b0 = rand(1,17)';


%1.score
%2.label
%3.diff 

%1.score
data = load('dataset.csv');
A1 = data(:,1:12);
%A = [A';B']';
b = data(:,13);

%2.label
data2 = load('stock.csv'); 
A2 = data2(:, 2:6); 

%3.label
%data3 = load('diff.csv'); 
%A3 = data(:,1); 

A = [A1 A2]; 
b = data(:,13); 
%Leave 126 cases
%Divide into folders

folderSize = 14;
folderNumber = 9;
dataSize = folderSize*folderNumber;
A = A(1:dataSize,:);
b = b(1:dataSize,:); 

%timeseries_error_rate = zeros([1 (folderNumber-1)]);
lambda = [1/8, 2/8, 3/8, 4/8, 5/8, 6/8, 7/8, 1, 2, 4, 8]
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



figure(1)
hold on
xlabel('time-series CV folder')
ylabel('error rate');
folder = 1:folderNumber-1; 
for i = 1:length(lambda)
    plot(folder, error_rate_lasso(:,i))
end
grid on
grid minor
hold off

figure(2)
hold on
xlabel('time-series CV folder')
ylabel('Sparsity');
folder = 1:folderNumber-1; 
for i = 1:length(lambda)
    plot(folder, sparsity(:,i)/17)
end
grid on
grid minor
hold off


