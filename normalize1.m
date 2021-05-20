function[Y]=normalize1(X)
Y=zeros(size(X));
minX=min(X(:));
maxX=max(X(:));
if maxX>minX
    Y=(X-minX)./(maxX-minX);
else
    Y=zeros(size(X));
end
end