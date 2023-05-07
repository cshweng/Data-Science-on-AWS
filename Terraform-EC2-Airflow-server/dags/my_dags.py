from datetime import datetime
from airflow import DAG
from airflow.operators.bash import BashOperator

default_args = {
    'owner': 'airflow',
    'start_date': datetime(2022, 1, 1),
    'retries': 1
}

with DAG('my_dag', default_args=default_args, schedule_interval='@daily', catchup=False) as dag:

    task1 = BashOperator(
        task_id='execute_script1',
        bash_command='/scripts/script1.sh'
    )

    task2 = BashOperator(
        task_id='execute_script2',
        bash_command='/scripts/script2.sh'
    )

    task1 >> task2