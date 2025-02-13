%% for loop
for i=1:10
    disp(i);
end

%% sum of first 10 natural numbers
sum=0;
for i=1:10
    sum=sum+i;
end
disp(sum);

%% factorial of n numbers
x=input("Enter Total Numbers: ");
fact=1;
for i=1:x
    fact=fact*i;
end
disp(fact);

%% generate a multiplication table for a given number
x=input("Enter the table no: ");
for i=1:10
    disp(x*i);
end

%% sum of square of 20 natural numbers
sum=0;
for i=1:20
    sum=(i*i)+sum;
end
display(sum);

%% to find all the prime numbers between 1 to 100 using for loop and mathematical operation
prime_no=[];
for i=2:100
    isprime=true;
    for division=2:sqrt(i)
        if mod(i,division)==0
            isprime=flase;
            break;
        end
    end
    if isprime
        prime_no
