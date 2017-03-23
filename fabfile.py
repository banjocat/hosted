from fabric.api import local, lcd, run, env, hide

env.hosts = 'www.giantdino.com'
env.user = 'root'

def ansible(name='all', tags='all'):
    """Runs the entire ansible"""
    with lcd('./ansible'):
        local((
        'ansible-playbook -D '
        '-u root '
        '--tags {1} '
        '--vault-password-file ../vault-pass '
        '-i ./inventory/hosted.ini '
        '{0}.yml'
        ).format(name, tags))

def rotate_certs():
    """Rotates cert"""
    # hacky way to get the task to run again
    # Forces the ansible task to run again
    run('sudo rm -rf /root/certbot-auto')
    with lcd('./ansible'):
        local(
        'ansible-playbook -D '
        '-u root '
        '--vault-password-file ../vault-pass '
        '--tags rotate_cert '
        '-i ./inventory/hosted.ini '
        'nginx.yml'
        )

