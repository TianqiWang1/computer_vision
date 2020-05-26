% match descriptors
%
% Input:
%   descr1        - k x n descriptor of first image
%   descr2        - k x m descriptor of second image
%   thresh        - scalar value to threshold the matches
%   
% Output:
%   matches       - 2 x w matrix storing the indices of the matching
%                   descriptors

function matches = matchDescriptors(descr1, descr2, thresh)

matches = [];
%compute the SSD between the two descriptor vectors
for i=1:size(descr1,2)
    % store a list of sdd 
    ssd_list = [];
    for j=1:size(descr2,2)
        %add (idx,ssd) pair for ssd below threshold to the list
        ssd = sum((descr2(:,j)-descr1(:,i)).^2);
        if (ssd <= thresh)
            ssd_list = [ssd,j; ssd_list];
        end
    end
    %take the index for smallest ssd
    % add (i,j) to matches
    if (size(ssd_list,1)>0)
        [v, idx]=min(ssd_list(:,1));
        matches=[[i ssd_list(idx, 2)]', matches];
    end
    
end   

end