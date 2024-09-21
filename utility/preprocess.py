"""
                                                               _ooOoo_
                                                              o8888888o
                                                              88" . "88
                                                              (| -_- |)
                                                              O\  =  /O
                                                           ____/`---'\____
                                                         .'  \\|     |//  `.
                                                        /  \\|||  :  |||//  \
                                                       /  _||||| -:- |||||-  \
                                                       |   | \\\  -  /// |   |
                                                       | \_|  ''\---/''  |   |
                                                       \  .-\__  `-`  ___/-. /
                                                     ___`. .'  /--.--\  `. . __
                                                  ."" '<  `.___\_<|>_/___.'  >'"".
                                                 | | :  `- \`.;`\ _ /`;.`/ - ` : | |
                                                 \  \ `-.   \_ __\ /__ _/   .-` /  /
                                            ======`-.____`-.___\_____/___.-`____.-'======
                                                               `=---='
                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                                        佛祖保佑       永无BUG
"""
import pandas as pd

time_range = [5, 26]
data_path = '../data/G2/'
processed_prefix = 'processed_'
file_names = [
    'processed_freq1.csv',
    'processed_freq2.csv',
    'processed_freq3.csv',
    'processed_freq4.csv',
    'processed_step1.csv',
    'processed_step2.csv',
    'processed_step3.csv',
    'processed_step4.csv']

for i, file_name in enumerate(file_names):
    try:
        full_path = data_path + file_name
        df = pd.read_csv(full_path)
        init_filtered_df = df[df['start_ident_flag'] != 0]
        time_filtered_df = init_filtered_df[(init_filtered_df['Time'] >= time_range[0]) & (init_filtered_df['Time'] <= time_range[1])]
        processed_file_path = data_path + processed_prefix + file_name
        df.to_csv(processed_file_path, index=False)

    except FileNotFoundError:
        print(f'File {full_path} not found.')
    except Exception as e:
        print(f'An error occurred while reading {full_path}: {e}')
