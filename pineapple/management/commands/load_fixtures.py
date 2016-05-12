from django.core.management.base import BaseCommand


class Command(BaseCommand):
    def handle(self, *args, **options):
        from django.core.management import execute_from_command_line
        import sys
        
        execute_from_command_line([sys.argv[0], 'loaddata', 'initial_data'])
