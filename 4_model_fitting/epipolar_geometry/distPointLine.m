function d = distPointLine( point, line )
% d = distPointLine( point, line )
% point: inhomogeneous 2d point (2-vector)
% line: 2d homogeneous line equation (3-vector)

d = abs((line(1)*point(1)+line(2)*point(2)+line(3))/sqrt(line(1)^2+line(2)^2));

end