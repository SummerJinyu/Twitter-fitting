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

%{
%Leave 126 cases
A = A(1:126,:);
%Divide into folders
dataSize = 126;
folderSize = 14;
folderNumber = 9;
%}
folderSize = 14;
folderNumber = 9;
dataSize = folderSize*folderNumber;
A = A(1:dataSize,:);

%use the last folder as test data
i = folderNumber - 1;               
startIndex = folderSize*i+1;
stopIndex = folderSize*i+folderSize;
testInd = false(1,dataSize);
testInd(startIndex:stopIndex) = true;

test_A = A(testInd,:);
test_b = b(testInd,:);   
train_A = A(~testInd,:); %115*12
train_b = b(~testInd,:); %115*1

result = int8(test_A*linsolve(train_A,train_b)>0.5);
error_rate = sum(test_b ~= result)/folderSize; 
error_rate




timeseries_error_rate = zeros([1 (folderNumber-1)]);
for i = 1:(folderNumber-1)
    startIndex = 1;
    endIndex = folderSize*(i-1)+folderSize;
    trainIndex = false(1,(i+1)*folderSize);
    trainIndex(startIndex:endIndex) = true;
    train_A = A(trainIndex,:);
    train_b = b(trainIndex,:);
    test_A = A(~trainIndex,:);
    test_b = b(~trainIndex,:);
    %{
    train_A = A(startIndex:endIndex,:);
    train_b = b(startIndex:endIndex,:);
    test_A = A(endIndex+1:endIndex + folderSize, :);
    test_b = b(endIndex+1:endIndex + folderSize, :); 
    %}
    result = int8(test_A*linsolve(train_A,train_b)>0.5);
    %result(result==0)=-1; 
    timeseries_error_rate(i) = sum(test_b ~= result)/folderSize;
end

timeseries_error_rate
mean(timeseries_error_rate)

figure(3) 
hold on 
plot(timeseries_error_rate); 
grid on 
grid minor
hold off
