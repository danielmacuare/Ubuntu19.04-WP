#!/usr/bin/env/python3
from configparser import ConfigParser, ExtendedInterpolation
from pathlib import Path

working_dir = Path.cwd()

def read_config_file():
    parser = ConfigParser(interpolation=ExtendedInterpolation())
    parser.read()
    print(parser.sections())
    return None

def create_default_conf():
    conf_file_path = f'{working_dir}/webdev.ini'
    log_file_path = f'{working_dir}/webdev.log'
    
    config = ConfigParser()
    print(f'Current working dir{Path.cwd()}')
    config['settings'] = {
        'packages_file': 'packages.txt', 
        'log_path': str(log_file_path)
    }

    with open (conf_file_path, 'w') as f:
        config.write(f)
    print(f'A config file has been created at --> "{conf_file_path}"')
    return None
