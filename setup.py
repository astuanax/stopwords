#!/usr/bin/env python
# -*- coding: utf-8 -*-


try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup


with open('README.rst') as readme_file:
    readme = readme_file.read()

with open('HISTORY.rst') as history_file:
    history = history_file.read().replace('.. :changelog:', '')

requirements = [
    # TODO: put package requirements here
]

test_requirements = [
    # TODO: put package test requirements here
]

setup(
    name='stopwords',
    version='1.0.1',
    description="Stopwords filter for 42 languages",
    long_description=readme + '\n\n' + history,
    author="Len Dierickx",
    author_email='len@astuanax.com',
    url='https://github.com/astuanax/stopwords',
    download_url = 'https://github.com/astuanax/stopwords/tarball/0.1', # I'll explain this in a second
    packages=[
        'stopwords',
    ],
    package_dir={'stopwords':
                 'stopwords'},
    include_package_data=True,
    package_data={
        'stopwords': [
            'languages/*/*.txt',
            'languages/languages.json',
        ]
    },
    install_requires=requirements,
    license="ISCL",
    zip_safe=False,
    keywords=['stopwords','language processing','nlp','filter'],
    classifiers=[
        'Development Status :: 5 - Production/Stable',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: ISC License (ISCL)',
        'Natural Language :: English',
        "Programming Language :: Python :: 2",
        'Programming Language :: Python :: 2.6',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3.6',
        'Topic :: Scientific/Engineering :: Artificial Intelligence'
    ],
    #test_suite='tests',
    #tests_require=test_requirements
)
