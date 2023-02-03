IP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=jenkins" --query 'Reservations[*].Instances[*].PublicIpAddress' --output text)

echo '{
        "Comment": "CREATE/DELETE/UPSERT a record ",
        "Changes": [{
          "Action": "UPSERT",
          "ResourceRecordSet": {
            "Name": "jenkins.devopshemasri.online",
            "Type": "A",
            "TTL": 30,
            "ResourceRecords": [{ "Value": "IPADDRESS"}]
          }}]
      }' | sed -e "s/IPADDRESS/${IP}/"