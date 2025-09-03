#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo "Usage: ./log-erchiver.sh <logs_dir> <path_to_archive_dir>"
    exit 1
fi

LOG_DIR=$1
ARCHIVE_DIR=$2

if [[ ! -d $LOG_DIR ]]; then
    echo "Error: directory with logs does not exist!"
    exit 2
fi

if [[ ! -d $ARCHIVE_DIR ]]; then
    echo "This directory does not exist"

    while true; do
        read -p "Do you want to create this directory and continue? [Y/n] " answer
        
        answer=${answer,,}
        answer=${answer:-y}
        
        case "$answer" in
            y|yes)
                mkdir -p "$ARCHIVE_DIR"
                if [[ $? -eq 0 ]]; then
                    echo "Directory '$ARCHIVE_DIR' created successfully"
                    break
                else
                    echo "Error: Failed to create directory '$ARCHIVE_DIR'" >&2
                    exit 1
                fi
                ;;
            n|no)
                echo "Operation cancelled by user"
                exit 1
                ;;
            *)
                echo "Invalid input. Please answer with 'y' or 'n'"
                ;;
        esac
    done
fi

timestamp_dir="logs_archive_$(date +'%Y%m%d_%H%M%S')"

tar -czf "${ARCHIVE_DIR}/${timestamp_dir}.tar.gz" "$LOG_DIR" 2>/dev/null