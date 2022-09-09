function x = pn_generate(p)
N = length(p) - 1;
p = fliplr(p);
X = [1 zeros(1,N-1)];
for i = 1:(2^N - 1)
    x(i) = X(1);
    X = [X(2:N) p(N + 1)*rem(sum(p(1:N).*X(1:N)),2)];
end
end