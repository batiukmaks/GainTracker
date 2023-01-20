"""Ordering exercises in workouts

Revision ID: 9eea542d9b31
Revises: 5efb2da87a0a
Create Date: 2023-01-20 19:57:35.472589

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '9eea542d9b31'
down_revision = '5efb2da87a0a'
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('workout_exercise', sa.Column('sequence_number', sa.Integer(), nullable=True))
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('workout_exercise', 'sequence_number')
    # ### end Alembic commands ###