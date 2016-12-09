function save_dll(filename, nbins)
x = xlsread(filename, 'C2:G122');
[~, ncol] = size(x);

% δ��һ��
m = mean(x);
s = std(x);
v = var(x);
xlswrite(filename, {'��ֵ'}, 'B123:B123');
xlswrite(filename, m, 'C123:G123');
xlswrite(filename, {'��׼��'}, 'B124:B124');
xlswrite(filename, s, 'C124:G124');
xlswrite(filename, {'����'}, 'B125:B125');
xlswrite(filename, v, 'C125:G125');

% ��һ��
norm_x = mapminmax(x')';
mn = mean(norm_x);
sn = std(norm_x);
vn = var(norm_x);
xlswrite(filename, {'��ֵ'}, 'B131:B131');
xlswrite(filename, mn, 'C131:G131');
xlswrite(filename, {'��׼��'}, 'B132:B132');
xlswrite(filename, sn, 'C132:G132');
xlswrite(filename, {'����'}, 'B133:B133');
xlswrite(filename, vn, 'C133:G133');

data = [];
for i=1:ncol
    h = hist(x(:, i), nbins);
    data = [data, [mean(h); std(h); var(h)]];
%     row_end = 71 + nbins - 1;
%     xlswrite(filename, m, ['C71:C', num2str(row_end)]);
    hist(x(:, i));
    saveas(gcf, [filename(1:end-5), num2str(i), '.jpg'])
end
xlswrite(filename, data, 'C127:G129')

data = [];
for i=1:ncol
    h = hist(norm_x(:, i), nbins);
    data = [data, [mean(h); std(h); var(h)]];
%     row_end = 71 + nbins - 1;
%     xlswrite(filename, m, ['C71:C', num2str(row_end)]);
    hist(norm_x(:, i));
    saveas(gcf, [filename(1:end-5), num2str(i), 'n.jpg'])
end
xlswrite(filename, data, 'C135:G137')

xlswrite(filename, {'δ��һ��'}, 'A123:A123');
xlswrite(filename, {'��һ��'}, 'A131:A131');