% 分区赛全向，yaw轴6020（关闭电流环）的系统辨识建模总成
% 输入电压，输出角速度反馈
% 频率响应作为数据集，阶跃响应作为验证集
%% 构建辨识对象
clc;
clear;
% 根据实际修改采样间隔和文件路径
dt = 0.001;
step_data_paths = {
    './data/G2/processed_step1';
    './data/G2/processed_step2';
    './data/G2/processed_step3';
    './data/G2/processed_step4';};
freq_data_paths = {
    './data/G2/processed_freq1'; 
    './data/G2/processed_freq2'; 
    './data/G2/processed_freq3'; 
    './data/G2/processed_freq4';};

addpath('./utility');
step_data_set = cell(length(step_data_paths), 1);
freq_data_set = cell(length(step_data_paths), 1);
for i = 1:length(step_data_paths)
    step_data_set{i} = create_iuput_output_data_object_from_csv(step_data_paths{i}, dt);
    figure(i)
    idplot(step_data_set{i})
end
for i = 1:length(freq_data_paths)
   freq_data_set{i} = create_iuput_output_data_object_from_csv(freq_data_paths{i}, dt);
   idplot(freq_data_set{i})
end
% %%
% merge(freq_data_set{1}, freq_data_set{2});
% temp_data = fft(freq_data_set{1});
% plot(temp_data);
%% 传递函数模型，辨识，验证
Options = tfestOptions;
Options.WeightingFilter = [6.28 62.8];
G1 = tfest(freq_data1, 1, 0, Options)
G2 = tfest(freq_data2, 1, 0, Options)
G3 = tfest(freq_data3, 1, 0, Options)
G4 = tfest(freq_data4, 1, 0, Options) 
Opt = arxOptions;
arx117 = arx(freq_data2,[1 1 7], Opt);
Options = tfestOptions;                            
 Options.WeightingFilter = [6.28 62.8];             
                                                    
 tf5 = tfest(freq_data2, 1, 0, Options, 'Ts', 0.001)
  Options = n4sidOptions;                                     
 Options.WeightingFilter = [6.28 62.8];                      
                                                             
 ss3 = n4sid(freq_data2, 5, 'Form', 'free', 'Ts', 0, Options)
  Options = n4sidOptions;                                     
 Options.WeightingFilter = [6.28 62.8];                      
 Options.Focus = 'simulation';                               
                                                             
 ss9 = n4sid(freq_data2, 5, 'Form', 'free', 'Ts', 0, Options)