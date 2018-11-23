#!/usr/bin/env python3

import json
import requests
import sys
import argparse


def fetch_commits_from_repo(user, repo, token):
    per_page = 100

    commits = []
    current_page = 1
    while True:
        print('loading page: %(current_page)s' % locals())
        resp = requests.get(
            'https://api.github.com/repos/%(user)s/%(repo)s/commits?page=%(current_page)s&per_page=%(per_page)s' % locals(),
            headers = {'Authorization': 'token %(token)s' % locals()}
        ).json()
        for data in resp:
            try:
                if not data['committer'] or not data['author']:
                    continue # skip if there is no author/committer
                commit = {
                    'sha': data['sha'], 'message': data['commit']['message'], 'date': data['commit']['committer']['date'],
                    'author': {'id': data['author']['id'], 'name': data['commit']['author']['name'], 'login': data['author']['login']}
                }
                commits.append(commit)
            except:
                print(sys.exc_info())
                print(data)
                print(resp)
                sys.exit(0)
                
        if len(resp) < per_page:
            break
        current_page += 1
    return commits


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Fetch commits in realm-core repo")
    parser.add_argument('--token', type=str, help='Github Access Token')
    args = parser.parse_args()

    if not args.token:
        parser.print_help()
        sys.exit()
    
    user = 'realm'
    repo = 'realm-core'
    commits = fetch_commits_from_repo(user, repo, args.token)
    with open('%(repo)s.json' % locals(), 'w') as f:
        json.dump(commits, f)
